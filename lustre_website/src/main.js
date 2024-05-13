import "./styles/global.css";
import { main } from "./lustre_website.gleam";
import Lenis from "@studio-freight/lenis";

main();

const lenis = new Lenis();

function raf(time) {
	lenis.raf(time);
	requestAnimationFrame(raf);
}

function onload() {
	document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
		anchor.addEventListener("click", function (e) {
			e.preventDefault();
			lenis.scrollTo(anchor.getAttribute("href"), {
				offset: -128,
			});
		});
	});
	handleScroll();
	requestAnimationFrame(raf);
}

window.onload = onload;

function handleScroll() {
	const header = document.getElementById("header");
	const announcementBar = document.getElementById("announcement_bar");

	window.scrollY > announcementBar.offsetHeight
		? header.classList.remove("transparent")
		: header.classList.add("transparent");
}

window.addEventListener("scroll", handleScroll);
