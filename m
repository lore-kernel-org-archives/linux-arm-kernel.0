From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 09:41:54 +0100
Subject: [PATCH 1/7] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
Message-ID: <20181105084154.l7g2dp33qlasgnrg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 12:06:28AM +0530, Jagan Teki wrote:
> MUX bits for MMC clock register range are 25:24 where 24 is shift
> and 2 is width So fix the width number from 3 to 2.
> 
> Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied for 4.21, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/0edea62c/attachment.sig>
