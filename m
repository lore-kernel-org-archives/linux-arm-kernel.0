From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Feb 2018 08:25:24 +0100
Subject: [PATCH v8 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <1519697566-32600-1-git-send-email-yong.deng@magewell.com>
References: <1519697566-32600-1-git-send-email-yong.deng@magewell.com>
Message-ID: <20180227072524.5pjoxoo4yowfw43v@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 10:12:46AM +0800, Yong Deng wrote:
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patch implement a v4l2 framework driver for it.
> 
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
> 
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180227/b61918bb/attachment.sig>
