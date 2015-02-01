From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Feb 2015 14:55:45 +0100
Subject: [PATCH v3 02/10] clk: sunxi: Add support for sun9i A80 USB
 clocks and resets
In-Reply-To: <1422388455-25923-3-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
 <1422388455-25923-3-git-send-email-wens@csie.org>
Message-ID: <20150201135545.GC4827@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 03:54:07AM +0800, Chen-Yu Tsai wrote:
> The USB controller/phy clocks and reset controls are in a separate
> address block, unlike previous SoCs where they were in the clock
> controller. Also, access to the address block is controlled by a
> clock gate to AHB.
> 
> Add support for resets requiring a clock to be enabled when
> asserting/deasserting the reset controls, and add the sun9i USB
> clocks.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150201/bdfcb5e6/attachment.sig>
