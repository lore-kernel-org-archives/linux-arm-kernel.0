From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 25 Sep 2012 20:00:12 +0100
Subject: [PATCH 3/3] serial: pl011: allow very high baudrates
In-Reply-To: <CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
 <20120920190034.GB15609@n2100.arm.linux.org.uk>
 <CACRpkdY1ZxQoyGFO9OnKr0WYQzooxPGvZV8Gnr_YO_yT_+ddDw@mail.gmail.com>
 <20120921162543.1ed18775@pyramind.ukuu.org.uk>
 <CACRpkdakLAPmD0TQwe2VNhdePDuFv2KXD2U1xoP1C0axkx2p7A@mail.gmail.com>
 <20120921205603.436a0194@pyramind.ukuu.org.uk>
 <CACRpkdbjsbUJqMgKt1CyBMmCxMAMz0hhwxzn3T6MdTyYGymjLg@mail.gmail.com>
Message-ID: <20120925200012.6576167f@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> OK sorry for getting this backwards, so I was under the impression that
> BOTHER was an internal detail of the TTY layer, not to be or:ed on
> and passed in from the outside.

BOTHER is a speed setting like the other Bxxx values - it's an external
API.

> 
> Then everything makes perfect sense, I'll try to patch the caller
> instead for this "bug" and see what happens. Probably it JustWorks...

Cool
