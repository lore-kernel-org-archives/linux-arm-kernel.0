From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Apr 2018 17:05:18 +0200
Subject: [PATCH v3] ARM: dts: sunxi: Add sid for a83t
In-Reply-To: <20180419141103.38196-1-kevans@FreeBSD.org>
References: <20180419141103.38196-1-kevans@FreeBSD.org>
Message-ID: <20180419150518.nbeq5zelrl236grv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 09:11:03AM -0500, kevans at FreeBSD.org wrote:
> Allwinner a83t has a 1 KB sid block with efuse for security rootkey and thermal
> calibration data, add node to describe it.
> 
> a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
> supported in an external driver for FreeBSD.
> 
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/aa6c786a/attachment.sig>
