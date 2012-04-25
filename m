From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Apr 2012 10:06:10 +0800
Subject: [PATCH 1/3] ARM: imx: Add common imx cpuidle init functionality.
In-Reply-To: <20120424195127.GA3628@n2100.arm.linux.org.uk>
References: <20120423062739.GX3852@pengutronix.de>
 <20120423065259.GR26306@S2101-09.ap.freescale.net>
 <20120423065623.GA3852@pengutronix.de>
 <20120423071013.GS26306@S2101-09.ap.freescale.net>
 <20120423074856.GU20478@pengutronix.de>
 <CAMXH7KH1pwh7hJ=T30zxcWcx19wjXvr6Ff4OLy7fzqY5p79Fwg@mail.gmail.com>
 <20120424013841.GB26306@S2101-09.ap.freescale.net>
 <20120424075426.GP24211@n2100.arm.linux.org.uk>
 <20120424083603.GE26306@S2101-09.ap.freescale.net>
 <CAMXH7KFMcHoGeTRcPWR_ENK2R=nU134HgjnXpFUsYJTL9pbgrQ@mail.gmail.com>
 <20120424195127.GA3628@n2100.arm.linux.org.uk>
Message-ID: <CAAQ0ZWTR7PAFX6z6PpkBhGoy5qh6u-xjK16mVCHnSoi-0GrD3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 April 2012 03:51, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Apr 24, 2012 at 10:40:35AM -0500, Rob Lee wrote:
>> Thanks for the attention on this. ?From what I've understood, I will
>> send another submission that includes the imx cpuidle patchset and
>> Shawn's device tree late initcall patchset and I'll provide
>> explanation of the two separate patchsets in the cover sheet.
>
> What I also want to see _along with_ the addition of the init_late
> callback is a patch set from the _same_ people fixing up the rest
> of arch/arm/mach-* to use it - you know, like what I do when I
> introduce these kinds of things.
>
> Otherwise I'm going to NAK the change. ?We can't have new stuff
> introduced in this way and the older platforms ignored. ?Forward
> progress across the board please.

I'm working on a series to clean them up.

Regards,
Shawn
