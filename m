From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 17:47:40 +0900
Subject: [PATCH 2/4] ARM: shmobile: Set CONFIG_LOCALVERSION in defconfigs
In-Reply-To: <CAMuHMdUSbvg593r_2prWaD9BsgXqw+sfur_S9Et5gX1a+v3PuA@mail.gmail.com>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
 <1388764128-27686-2-git-send-email-geert@linux-m68k.org>
 <20140106022758.GE11231@verge.net.au>
 <CAMuHMdUSbvg593r_2prWaD9BsgXqw+sfur_S9Et5gX1a+v3PuA@mail.gmail.com>
Message-ID: <20140106084739.GA16341@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 09:43:11AM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 6, 2014 at 3:27 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jan 03, 2014 at 04:48:46PM +0100, Geert Uytterhoeven wrote:
> >> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> >>
> >> This allows to derive the kernel flavor from the kernel version.
> >
> > Is this a common practice for ARM?
> 
> Not really, only 5 ARM deconfigs do that.
> Globally, ca. 10% of the Linux defconfigs do it.
> 
> > I'm a little hesitant to take this if its not.
> > Particularly as we are planing to deprecate these defconfigs
> > in favour of a shared multiplatform defconfig.
> 
> A shared multiplatform defconfig can still have
> CONFIG_LOCALVERSION="-shmobile", so you'll know it's a multiplatform
> kernel when you see the dmesg.

Not if it is shared more widely :^)
