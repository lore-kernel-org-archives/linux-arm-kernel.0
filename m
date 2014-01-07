From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 07 Jan 2014 16:52:48 +0100
Subject: [GIT PULL FOR v3.14] Renesas pinctrl fixes
In-Reply-To: <CACRpkdZTt=yQGyzD3AnzKF3RjGiC4WdDX3yQY7zw68VFeYf5oQ@mail.gmail.com>
References: <1497178.A4PLILmBU4@avalon>
 <CACRpkdZTt=yQGyzD3AnzKF3RjGiC4WdDX3yQY7zw68VFeYf5oQ@mail.gmail.com>
Message-ID: <1976554.0KiPFU2ADY@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tuesday 07 January 2014 16:50:31 Linus Walleij wrote:
> On Tue, Jan 7, 2014 at 9:42 AM, Laurent Pinchart wrote:
> > Hi Linus,
> > 
> > The following changes since commit 
44a45b55a72754e5c9ed047179fb269b530f45fc:
> >   pinctrl: sh-pfc: ARM: Constify pins and cfg_regs arrays (2013-12-20
> >   12:28:40 +0100)
> > 
> > are available in the git repository at:
> >   git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pfc
> 
> Pulled into my pinctrl/devel branch for v3.14.

Thank you.

> Now, what do I do about all the other Renesas pinctrl stuff that is
> floating? Like all the new stuff from Magnus &al? Do you keep track
> of that or should I start looking at it?

I wouldn't mind less work of course :-) but I was planning to keep track of 
the RZ pinctrl patches, at least for the next kernel version. Things will 
hopefully stabilize after that. I'm waiting for Magnus to repost his patch 
series (or at least reply to my comments).

-- 
Regards,

Laurent Pinchart
