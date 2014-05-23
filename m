From: imrehg@gmail.com (Gergely Imreh)
Date: Sat, 24 May 2014 00:10:58 +0800
Subject: [RFC] ARM: vt8500: cleanup start
Message-ID: <CAJ3iQco9qu8Z7Gm0AtcvV3OPc6C39Hdqjq6tVKMYy5qV2=ASwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is my first post on the list. I'm preparing to contribute to the
Kernel some of
the current SoCs and boards from VIA Embedded.

That being a big task (understatement), I'm just starting off with a
checking existing
things out around the vt8500 areas, and other SoCs to learn the style.

The style of march-v8500 is not quite like the ones I've seen in e.g.
Thomas Petazzoni
& Free Electrons' (very cool) guides, and started off with updating
things according
to that a bit. I'm just not sure whether this warrant any patches on
their own, hence the
Request for Comments.

The changes I've made (breaking out the #define sections into a
header, and doing
explicit typecast for the vt8500 map_desc) are in this repo with via-header tag.

https://github.com/viaembedded/arm-soc/tree/via-header

Should this be part of a larger patchset later on, or is it okay just
to send any time like
this? Are these changes worth doing if the functionality itself did
not really change,
just probably the style improves?

Would appreciate any kind of feedback.

Cheers,
   Greg
