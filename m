From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Oct 2014 21:44:33 +0200
Subject: [PATCH v2 2/5] clk: sunxi: Add support for A80 basic bus clocks
In-Reply-To: <1413814230-13735-3-git-send-email-wens@csie.org>
References: <1413814230-13735-1-git-send-email-wens@csie.org>
 <1413814230-13735-3-git-send-email-wens@csie.org>
Message-ID: <20141021194433.GT21108@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:10:27PM +0800, Chen-Yu Tsai wrote:
> The A80 SoC has 12 PLL clocks, 3 AHB clocks, 2 APB clocks, and a
> new "GT" bus, which I assume is some kind of data bus connecting
> the processor cores, memory and various busses. Also there is a
> bus clock for a ARM CCI400 module.
> 
> As far as I can tell, the GT bus and CCI400 bus clock must be
> protected.
> 
> This patch adds driver support for peripheral related PLLs and
> bus clocks on the A80. The GT and CCI400 clocks are added as well
> as these 2 along with the PLLs they are clocked from must not be
> disabled.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/9e38a12c/attachment.sig>
