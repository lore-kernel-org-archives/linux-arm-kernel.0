From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Jan 2015 17:00:27 +0100
Subject: [PATCH 02/17] clk: sunxi: Propagate rate changes to parent for
 mux clocks
In-Reply-To: <1420511727-8242-3-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
 <1420511727-8242-3-git-send-email-wens@csie.org>
Message-ID: <20150106160027.GT7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 10:35:12AM +0800, Chen-Yu Tsai wrote:
> The cpu clock on sunxi machines is just a mux clock, which is normally
> fed by the main PLL, but can be muxed to the main or low power oscillator.
> 
> Make the mux clock propagate rate changes to its parent, so we can
> change the clock rate of the PLL, and thus actually implement rate
> changing on the cpu clock.
> 
> This patch also removes the no reparenting limit.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/2182b9dc/attachment.sig>
