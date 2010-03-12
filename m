From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Mar 2010 09:12:05 -0800
Subject: [PATCH 17/19] omap: Add DSI regulator supply to OMAP3EVM board
	file
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DD32D7B@dbde02.ent.ti.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100311234847.4500.24584.stgit@baageli.muru.com>
	<19F8576C6E063C45BE387C64729E7394044DD32D7B@dbde02.ent.ti.com>
Message-ID: <20100312171204.GE2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [100311 20:45]:
> [Hiremath, Vaibhav] Tony,
> Please use the patch below, I have fixed Mark's comments to use devname instead of dev.

Sorry, looks like I missed Mark's comments while reading the
thread at:

http://patchwork.kernel.org/patch/84823/

I can't get either of your patches to apply. Please just repost your
whole patch against the 2.6.34-rc1 with the Acked-by from Tomi.

Also, please read the mailing list instructions we have at:

http://www.elinux.org/Netiquette

Basically one patch per mail. In format that can be applied as it is.
Patches inlined, not quoted-printable. I don't want to manually re-edit
the patches, it's a complete waste of time.
 
> diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
> deleted file mode 100644
> index e69de29..0000000

And this part we don't want to apply, it's not related to this patch.

Regards,

Tony
