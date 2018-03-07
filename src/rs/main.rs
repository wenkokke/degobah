#![feature(plugin)]
#![feature(proc_macro)]
#![plugin(rocket_codegen)]

extern crate maud;
extern crate rocket;

use std::path::{Path, PathBuf};
use rocket::response::NamedFile;

#[get("/")]
fn index() -> Option<NamedFile> {
  NamedFile::open(Path::new("static/main.html")).ok()
}

#[get("/<file..>")]
fn files(file: PathBuf) -> Option<NamedFile> {
  NamedFile::open(Path::new("static/").join(file)).ok()
}

fn main() {
  rocket::ignite().mount("/", routes![index,files]).launch();
}
