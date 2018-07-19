From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Jul 2018 16:40:54 +0200
Subject: [PATCH 1/2] soc: sunxi: Add the A13, A23 and H3 system control
 compatibles
In-Reply-To: <20180711092508.18751-1-maxime.ripard@bootlin.com>
References: <20180711092508.18751-1-maxime.ripard@bootlin.com>
Message-ID: <20180719144054.lqywc5c5y2bmzoze@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 11:25:07AM +0200, Maxime Ripard wrote:
> The A13, A23 and H3 have variations of the system controls, in part due to
> the SRAM that are available (and can be mapped) in the SoC.
> 
> In order to make it future proof, let's add compatibles for these SoCs in
> the driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied both.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/4b2fde97/attachment.sig>
