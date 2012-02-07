From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 13:37:15 +0000
Subject: [PATCH v2 3/7] ASoC: twl6040: Remove dependency on twl4030 from
 Kconfig
In-Reply-To: <1328619678-26080-4-git-send-email-peter.ujfalusi@ti.com>
References: <1328619678-26080-1-git-send-email-peter.ujfalusi@ti.com>
 <1328619678-26080-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120207133715.GO3332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 03:01:14PM +0200, Peter Ujfalusi wrote:

> -	select SND_SOC_TWL6040 if TWL4030_CORE
> +	select SND_SOC_TWL6040

I'd expect this to be changed to an if I2C rather than no dependency at
all?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/f87006b5/attachment.sig>
