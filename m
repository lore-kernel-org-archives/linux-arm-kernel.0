From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 8 Dec 2014 20:06:45 +0100
Subject: [PATCH] ARM: dts: sun6i: hummingbird: Add ethernet phy reset
 gpio properties
In-Reply-To: <1417591153-27177-1-git-send-email-wens@csie.org>
References: <1417591153-27177-1-git-send-email-wens@csie.org>
Message-ID: <20141208190645.GH8739@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 03:19:13PM +0800, Chen-Yu Tsai wrote:
> On the Hummingbird A31 board, the RTL8211E ethernet phy has its reset
> line connect to a gpio pin, instead of floating like on other boards.
> Add the stmmac properties for describing the reset gpio.
> 
> The reset delays were taken from the RTL8211E datasheet.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Queued, thanks.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/a345d5c7/attachment.sig>
