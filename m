From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 22 Feb 2012 12:47:55 +0200
Subject: [PATCHv10 3/4] omap3: add common twl configurations for vdd1
 and vdd2
In-Reply-To: <871upn4tzf.fsf@ti.com>
References: <1329733568-26676-1-git-send-email-t-kristo@ti.com>
 <1329733568-26676-4-git-send-email-t-kristo@ti.com> <871upn4tzf.fsf@ti.com>
Message-ID: <1329907675.4102.488.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-21 at 16:00 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > VDD1 and VDD2 are the core voltage regulators on OMAP3. VDD1 is used
> > to control MPU/IVA voltage, and VDD2 is used for CORE. These regulators
> > are needed by DVFS.
> >
> > Voltage ranges for VDD1 and VDD2 are taken from twl4030/twl5030 data manuals:
> > - SWCS019L : TWL4030 ES3.1 Data Manual rev L
> > - SWCS030E : TWL5030 ES1.2 Data Manual rev E
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Do you have a similar patch for OMAP4 support?

It looks like OMAP4 support requires some changes to the twl-regulator /
twl-core in addition to the twl-common.c. I have these available (just
created them), should I post these out? Attached here for reference in
case you need to test something quickly.

-Tero

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-regulator-twl6030-add-support-for-vdd1-vdd2-and-vdd3.patch
Type: text/x-patch
Size: 4563 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120222/46cb4716/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-arm-omap4-add-common-twl-configurations-for-vdd1-vdd.patch
Type: text/x-patch
Size: 3691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120222/46cb4716/attachment-0003.bin>
