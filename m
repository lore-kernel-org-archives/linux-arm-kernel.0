From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Jan 2014 17:52:34 +0900
Subject: [PATCH v2 0/8] SoC and board integration for RSPI on RZ/A1H
In-Reply-To: <CAMuHMdW5e74keNhRkSG6q6crGWZ0Gqtb5-hntbCUNm7Md78Bcw@mail.gmail.com>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <20140107012628.GD2196@verge.net.au>
 <CAMuHMdW5e74keNhRkSG6q6crGWZ0Gqtb5-hntbCUNm7Md78Bcw@mail.gmail.com>
Message-ID: <20140107085231.GA26477@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 09:31:17AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 7, 2014 at 2:26 AM, Simon Horman <horms@verge.net.au> wrote:
> >>     [1/8] pinctrl: sh-pfc: r7s72100: Add RSPI support
> >
> > I believe that Laurent should handle this.
> 
> Don't you mean Magnus? This is RZ/A1H, not R-Car.
> 
> >>     [2/8] ARM: shmobile: r7s72100: Add RSPI clocks
> >
> > This seems fine and independent of the other patches.
> > But unfortunately it no longer applies.
> >
> > Feel free to rebase it if you would like me to queue it up sooner
> > than later.
> 
> Will do.
> 
> >>     [3/8] ARM: shmobile: r7s72100: Add RSPI platform devices
> >
> > I assume this depends on 1/3.
> 
> 1/8? Or are you mixing up with 1/3 for Koelsch?

1/8

> Nevertheless, this just adds platform devices, so it should be fairly
> independent.

Ok, thanks. It sounds like I will be able to queue it up
once you repost the series.

> 
> > Please add a patch to update the koelsch defconfig.
> 
> Genmai defconfig, not koelsch.
> 
> >>     [4/8] ARM: shmobile: genmai: Add RSPI children (NEW)
> >
> > This seems reasonable but I assume it depends on earlier patches.
> 
> Yes, it's useless without 3/8. But I guess it will just fail to find the
> SPI bus.

Useless is ok. Its just breakage that I'm concerned about these days :^)

> > Please add a patch to update the koelsch defconfig or Kconfig.
> 
> Genmai ;-) Will do.

Yes, Genmai :)
