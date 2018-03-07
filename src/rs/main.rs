#![feature(plugin)]
#![feature(proc_macro)]
#![plugin(rocket_codegen)]

extern crate maud;
extern crate rocket;

use std::path::{Path, PathBuf};
use rocket::response::NamedFile;

#[get("/")]
fn index() -> Option<NamedFile> {
  NamedFile::open(Path::new("_build/index.html")).ok()
}

#[get("/<file..>")]
fn files(file: PathBuf) -> Option<NamedFile> {
  NamedFile::open(Path::new("_build/").join(file)).ok()
}

fn main() {
  rocket::ignite().mount("/", routes![index,files]).launch();
}
