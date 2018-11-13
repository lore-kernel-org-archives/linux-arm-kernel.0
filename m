From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 14:08:17 +0100
Subject: [PATCH v4 01/26] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
In-Reply-To: <20181113111633.20189-2-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-2-jagan@amarulasolutions.com>
Message-ID: <20181113130817.nols3red37yj3yit@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 04:46:08PM +0530, Jagan Teki wrote:
> DSI DPHY gate bit on MIPI DSI clock register is bit 15
> not bit 30.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181113/05cf4f95/attachment.sig>
