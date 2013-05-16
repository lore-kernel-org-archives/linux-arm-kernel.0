From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 May 2013 09:21:45 -0700
Subject: [PATCH] ARM: dts: OMAP2+: Simplify NAND support
In-Reply-To: <1367331082-27944-1-git-send-email-jon-hunter@ti.com>
References: <1367331082-27944-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20130516162144.GY5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130430 07:16]:
> Commit 8c8a777 (ARM: OMAP2+: Add function to read GPMC settings from
> device-tree) added a device-tree property "gpmc,device-nand" to indicate
> is the GPMC child device is NAND. This commit should have updated the
> GPMC NAND documentation (Documentation/devicetree/bindings/mtd/gpmc-nand.txt)
> to list the property "gpmc,device-nand" as a required property and also
> updated the example. However, this property is redundant and not needed
> because the GPMC child device node for NAND is called "nand". Therefore,
> remove this property.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks applying into omap-for-v3.11/gpmc.

Regards,

Tony
