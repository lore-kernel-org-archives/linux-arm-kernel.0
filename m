From: mporter@ti.com (Matt Porter)
Date: Fri, 28 Sep 2012 16:48:16 -0400
Subject: [PATCH RESEND 0/5] ARM: dts: AM33XX: Add device tree data
In-Reply-To: <505A3D4C.4090502@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
 <B7CE1C39EBFBA0428A012975D4B2FC830B5DF78F@DNCE05.ent.ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA34232@DBDE01.ent.ti.com>
 <505A3D4C.4090502@ti.com>
Message-ID: <20120928204816.GI5641@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 04:46:52PM -0500, Benoit Cousson wrote:
> + Matt
> 
> On 9/19/2012 4:28 PM, AnilKumar, Chimata wrote:
> >On Thu, Sep 20, 2012 at 02:53:38, Cousson, Benoit wrote:
> >>+ Paul
> >>
> >>Hi Anil,
> >>
> >>Thanks for the rebase / repost. I'll pulled the full series if Paul is OK with
> >>   ARM: OMAP2+: AM33XX: Add clock entries to omap_clk data
> >>
> 
> What about Matt's series to fix the I2C number? Should it be applied
> on top of that one?

I had the series to fix the GPIO numbering [1]. It's dependent on this
series which carries the led dts patch. Pantelis has a patch for i2c
dts numbering in his i2c series [2]. A hunk in that patch has support
for his i2c pinctrl series mixed in (not sure where that one is due to
the change to early init) so it doesn't apply cleanly alone on top of
for_3.7/dts_part2. If you're willing to pick up that i2c renumbering by
itself I can drop you a patch just for that part.

-Matt

[1] https://patchwork.kernel.org/patch/1433481/
    https://patchwork.kernel.org/patch/1433471/

[2] https://patchwork.kernel.org/patch/1474001/

> 
> Regards,
> Benoit
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
