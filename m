From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 20:51:07 +0200
Subject: [PATCH] ARM: dts: sun8i-h3: sinovoip-bpi-m2-plus: Fix LED and
 switch labels
In-Reply-To: <1465371386-14479-1-git-send-email-wens@csie.org>
References: <1465371386-14479-1-git-send-email-wens@csie.org>
Message-ID: <20160609185107.GG5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 03:36:26PM +0800, Chen-Yu Tsai wrote:
> The switch is clearly labeled "power" on the board.
> 
> The LED is red, and is lit by default through an external pull up.
> Label it as "pwr" even though there is no explicit marking.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Maxime,
> 
> This patch fixes 2 copy paste errors in the bpi-m2+ dts that slipped
> through. Can you squash it into my original patch?

Done, thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/0167a3bd/attachment.sig>
