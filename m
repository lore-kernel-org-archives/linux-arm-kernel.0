From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 14:52:29 +0200
Subject: [PATCHv11 0/6] I2C cleanups
In-Reply-To: <CAM=Q2ct0PUisYGcaX6EAPWT-SmZAgRV_O8mAOodH-V4Q0O-Vww@mail.gmail.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <CAM=Q2ct0PUisYGcaX6EAPWT-SmZAgRV_O8mAOodH-V4Q0O-Vww@mail.gmail.com>
Message-ID: <20120712125229.GG2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 05:17:07PM +0530, Shubhrajyoti Datta wrote:
> On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> > This is a minimal cleanup series.
> 
> If there are no further comments can this series be queued?

I just applied a few of them. BTW I get a build warning when compiling the
kernel, maybe someone is interested. It is not related to the patches, though.

===

WARNING: arch/arm/mach-omap2/built-in.o(.data+0x2b5c0): Section mismatch in reference from the variable rx51_si4713_dev to the (unknown reference) .init.data:(unknown)
The variable rx51_si4713_dev references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

===

I think this is what I'll pull in for the next merge window. The big OMAP
cleanup (latest version from 3. July) would then go in early into -next for
3.7. Is that OK with the omap-people?

Also, thanks to Shubhrajyoti Datta for reviewing other patches on the
i2c-list, much appreciated.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/7065ea3b/attachment.sig>
