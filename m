From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 14:52:10 +0000
Subject: [PATCH 0/4] Add s3c64xx support to touchscreen driver
In-Reply-To: <b2e8f9f71001221447r56b29abboa81736fb1451cdde@mail.gmail.com>
References: <b2e8f9f71001221447r56b29abboa81736fb1451cdde@mail.gmail.com>
Message-ID: <20100126145210.GC9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2010 at 11:47:05PM +0100, Maurus Cuelenaere wrote:
> Hi,
> 
> these patches add support for the s3c64xx platforms to the touchscreen driver.
> This was based on next-samsung in Ben Dook's tree.
> 
> These depend on:
> [PATCH] ARM: SAMSUNG: Fix null pointer dereference in ADC driver

should be in for-rmk/samsung3
 
> I'm not quite sure regarding the resources in patch 3, perhaps these should be
> somehow shared with the ADC driver? (I also can't seem to figure out how the
> s3c24xx handles this at the moment..)

I'll try and give this some thought, however we're in the middle of some
reworks in this area and it might take time to think about it.
 
> Regards,
> Maurus Cuelenaere
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
