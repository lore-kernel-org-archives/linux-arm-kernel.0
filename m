From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Mar 2011 23:08:17 +0530
Subject: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
	<AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
Message-ID: <7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,
> -----Original Message-----
> From: Dave Martin [mailto:dave.martin at linaro.org]
> Sent: Friday, March 04, 2011 11:05 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: patches at linaro.org; Tony Lindgren; Santosh Shilimkar; Jean
> Pihet; Kevin Hilman; linux-omap at vger.kernel.org; Nicolas Pitre;
> linaro-dev at lists.linaro.org
> Subject: Re: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2
> compatibility fixes
>
> On Fri, Mar 4, 2011 at 3:33 PM, Dave Martin <dave.martin@linaro.org>
> wrote:
> > This set of patches, along with some other patches under
> > discussion on alkml, should enable omap3 and omap4 kernels to be
> > built with CONFIG_THUMB2_KERNEL.
> >
> > This patch set builds on recent cleanup done by the omap
> > maintainers.
> >
> > At least some of this code definitely works, most features have
> > been tested successfully. ?Further testing, especially of Thumb-2
> > behaviour, is still welcome.
> >
> > In particular, I still have no Ack/Tested-by on the following
> > patches, so it would be great if anyone who has an opportunity
> > to do a final review / re-test can do so.
> >
> > ?* ARM: omap3: Convert END() to ENDPROC() for correct linkage with
> CONFIG_THUMB2_KERNEL
> > ?* ARM: omap3: Thumb-2 compatibility for sram34xx.S
> > ?* ARM: omap3: Thumb-2 compatibility for sleep34xx.S
>
> Following up on this, it looks like I have some locally-recorded
> acks
> which didn't make it into my posting ...
>
> The one patch I currently have no feedback on is this one:
>
>   * ARM: omap4: Provide do_wfi() for Thumb-2
>
You can drop this one since do_wfi()  won't be needed
anymore after my recent series.

http://www.spinics.net/lists/linux-omap/msg46495.html
