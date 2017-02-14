From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Feb 2017 10:39:48 +0100
Subject: [PATCH 2/5] clk: sunxi-ng: gate: Support common pre-dividers
In-Reply-To: <20170214033526.16977-3-wens@csie.org>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-3-wens@csie.org>
Message-ID: <20170214093948.d46xkfunpuj3nn7l@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 11:35:23AM +0800, Chen-Yu Tsai wrote:
> Some clock gates have a pre-divider between the source input and the
> gate itself. A notable example is the HSIC 12 MHz clock found on the
> A83T, which has the 24 MHz main oscillator as its input, and a /2
> pre-divider.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/1967bfcd/attachment-0001.sig>
