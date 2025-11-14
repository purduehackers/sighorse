//
// A monospaced theme for Typst documents.
// Copyright (C) 2025 Kian Kasad (@kdkasad) <kian@kasad.com>
// This project is licensed under the MIT License.
// See the provided LICENSE file for details.
//

#import "@preview/marge:0.1.0": sidenote
#import "@preview/droplet:0.3.1": dropcap
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes.diamond

#import "theme.typ": theme, title

// two different font styles to have fun with whoever notices
#show: theme.with(
  heading-font: "Iosevka SS05",
  body-font: "Iosevka SS03",
)
#set par(justify: true)
#set document(
  author: "Kartavya Vashishtha",
)

#let small-font-size = 8pt

#title[Foreword][Kart]

Hi! I'm Kart. I came up with SIGHORSE, made the website, and (sometimes) reviewed submissions from authors. I was, of course, helped immeasurably by many people without whom SIGHORSE would not be possible, but ideally you've already seen their names before this article.

I'd like to talk about SIGHORSE for a bit.

There are three parts to this foreword:
1. Why the word "horse"? Why is it relevant? What does it mean to Purdue Hackers?
2. Why work on this journal? What forces made us want to create SIGHORSE?
3. Can we see the process of making the cover? Surely it wasn't too much work.

= Bringing forth a longing for horsing into the world

#quote(
  attribution: [Purdue Hackers website, but I removed the emojis],
  block: true,
)[Purdue Hackers: a community of students who collaborate, learn, and build kick-ass technical projects.]

Since forever, horses have been intertwined with the Purdue Hackers brand.

Discord#footnote[Discord is an online group messaging platform used by Purdue Hackers. It is a centerpiece of the community, and many important discussions happen there.] archaeology points to a particular person starting the conversation off in September 2022 with messages like:
#quote(block: true)[
  - our mascot should be an 8-bit horse \
    Also the horse should be yellow \
  - Here's every horse: https://every.horse/ \
  - Here's a horse that's shaking: https://shakingmy.horse/
]

The discussion significantly escalated on the next day, when the same person posted:

#quote(
  block: true,
)[Today I forked my personal link shortener to use it for Purdue Hackers. Introducing `puhack.horse`#footnote[It redirects to https://www.purduehackers.com/] \ ...]

This person then served as the President of Purdue Hackers for three years, and led its rise from a 20 person meetup to a 80-100 person
organization with sprawling projects, ideas, and coolness.

Is it any surprise that a club that emphasizes engaging in whimsy and creating things that bring joy would latch on to "horse"?

= Putting the Special Interest Group in the Horse

We've established the importance of horses. Now, let's explore how the Special Interest Group part came about.

== BURSTing from creativity
In Fall 2024, Purdue Hackers hosted a showcase for a bunch of projects that members had created. They called it BURST#footnote[https://burst.purduehackers.com/]. It was glorious. Seriously. Here're some photos from BURST to show you just how glorious it was. _I strongly encourage you to check out the website for more photos and information on the exhibits._

#figure(caption: [], numbering: none, grid(
  columns: (1fr, 1fr),
  image("burst-photos/image.png"), block(inset: (left: -37.75pt, right: -37.75pt), clip: true)[#image("burst-photos/image copy 4.png", fit: "contain", height: 170pt)],
  image("burst-photos/image copy 2.png"), image("burst-photos/image copy 3.png")
))

BURST included (among other things) (in clockwise order):
- a phone bell whose insides had been replaced with a Raspberry Pi;
- the Purdue Hackers logo as a meter tall sign;
- a receipt printer; and
- an indie video game about running a boba shop.

It was so glorious, in fact, that it challenged my imagination to think of it even _could_ get more glorious. How could we ever top
the projects that we'd showcased this year? How could we inspire more members of Hackers to make contributions to the next showcase we hosted?

*How could _I_ engage more members and spread the joy of creating and presenting?*

== Commit Overflow
For the past two years, Purdue Hackers has hosted the "Commit Overflow" event during Purdue University's winter break.

#quote(block: true, attribution: "The first Commit Overflow announcement in 2022")[
  Winter break is here; it's the perfect time to make the things you didn't have time to make this semester.

  During the last 10 days of the year, we're running Commit Overflow. The challenge: every day, commit to GitHub & post an update of what you're working on in \#checkpoints#footnote[\#checkpoints is a "channel" in Discord; a channel is a discrete subdivision within a server which members send messages to. \#checkpoints, in particular, is a channel where people can showcase their in-progress creations.]

  If you make it all 10 days, we'll send you stickers and a custom laser-cut badge that will never be made or distributed again.
]

This event saw great participation from the community: people shipped commits and maintained a sense of connection over the break. I personally wrote a lot of documentation for keymashed#footnote[https://github.com/kartva/keymashed], a project I'd showcased at BURST.

== SIGBOVIK

Now to talk about something completely different: SIGBOVIK#footnote[https://sigbovik.org/] (Special Interest Group in Harry Quark Bovik) is an yearly joke journal organized primarily by grad students from Carnegie Melon University with clearly too much time on their hands.

Their name plays on the Association for Computing Machinery's many conferences that start with SIG#footnote[https://www.acm.org/special-interest-groups/alphabetical-listing]: SIGPLAN (Special Interest Group on Programming Languages), SIGGRAPH (Special Interest Group on Graphics), SIGMICRO (Special Interest Group on Microarchitecture), etc.

The latest edition is just over 400 pages long. Papers published in this illustrious journal have had titles such as
_"An Empirically Verified Lower Bound for The Number Of Empty Pages Allowed In a SIGBOVIK Paper"_ or _"A Genius Solution: Applications of the Sprague-Grundy Theorem to Korean Reality TV"_.

#figure()[
  #diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,

    node(
      (0, 0),
      align(center)[Did you read \ SIGHORSE?],
      shape: diamond,
      name: "read",
      height: 1.25cm,
    ),

    node(
      (3, 0),
      align(center)[Did you enjoy \ SIGHORSE?],
      shape: diamond,
      name: "enjoy",
      height: 1.25cm,
    ),
    node(
      (6, 0),
      [You should read \ SIGBOVIK.],
      shape: rect,
      name: "end",
    ),
    edge(
      <read>,
      <enjoy>,
      [Yes],
      "->",
      label-side: left,
    ),
    edge(
      <read>,
      <enjoy>,
      text(size: small-font-size)["Thanks!"],
      label-side: right,
    ),
    edge(
      <read>,
      <end>,
      [No],
      "->",
      bend: -30deg,
      label-side: left,
    ),
    edge(
      <read>,
      <end>,
      text(size: small-font-size)["If you didn't read SIGHORSE, \
        SIGBOVIK may be interesting."],
      bend: -30deg,
      label-side: right,
    ),
    edge(
      <enjoy>,
      <end>,
      [Yes],
      "->",
      label-side: left,
    ),
    edge(
      <enjoy>,
      <end>,
      align(center)[#text(size: small-font-size)["More of \ the same!"]],
      label-side: right,
    ),
    edge(
      <enjoy>,
      <end>,
      [No],
      "->",
      bend: 50deg,
      label-side: right,
    ),
    edge(
      <enjoy>,
      <end>,
      align(center)[#text(size: small-font-size)["If you didn't enjoy SIGHORSE, \
        maybe SIGBOVIK would be more your speed."]],
      bend: 50deg,
      label-side: left,
    ),
  )]

= Messily pushing the horsing out to the world
== Defining SIGHORSE
Finally, we can unify the two topics we discussed in the previous sections: SIGHORSE was proposed as "what if we ran something like Commit Overflow but in the summer and with a focus on whimsy and silliness?" Our tenets would be:
- encourage people to build cool things over the summer!
- talk about said things!
- get those things to a presentable state so we could put them in the journal!

To give an idea of the things SIGHORSE would cover, I produced the following diagram:

#figure()[
  #image("sighorse-vs-all-other-conferences.svg")
]

Simply put, SIGHORSE was to be inclusive.

(Before you ask, someone did measure the size of the horses and found it to be around 8.7#sym.times larger than the "every other scientific journal" cloud.)

== Enough about SIGHORSE, what about the cover?
I'm so glad you asked about the cover! I first learned Blender#footnote[3D modeling software: https://www.blender.org/], then Krita#footnote[Vector/Raster painting software: https://krita.org/en/], then Inkscape#footnote[Raster drawing software: https://inkscape.org/], and then finally handed it off to an artist to finish because I sure couldn't.

#figure(caption: [counterclockwise: first Blender draft, alternate Blender draft, Krita draft. \ You can find the final version by looking at the cover.], numbering: none)[
  #grid(
    columns: (.94fr, 1fr),
    image("covers/blender-storm.png"),
    grid.cell(rowspan: 2, image("covers/sighorse-krita-3.png")),
    image("covers/blender-paper-wings.png"),
  )]

= As the show curtains descend on the horse
SIGHORSE has been a blast. I hope you'll enjoy reading the submissions as much as the authors enjoyed creating them.