From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 15 Jan 2014 08:44:58 +0100
Subject: [PATCH v3 3/8] clk: sunxi: add names for pll5, pll6 parent
 clocks to factors_data
In-Reply-To: <1389257565-19797-4-git-send-email-wens@csie.org>
References: <1389257565-19797-1-git-send-email-wens@csie.org>
 <1389257565-19797-4-git-send-email-wens@csie.org>
Message-ID: <20140115074458.GA3377@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 09, 2014 at 04:52:40PM +0800, Chen-Yu Tsai wrote:
> Some factor clocks, such as the parent clock of pll5 and pll6, have
> multiple output names. Add the corresponding names to factors_data
> tied to compatible string.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/086d0cfd/attachment.sig>
