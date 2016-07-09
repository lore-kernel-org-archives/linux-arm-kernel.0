From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 9 Jul 2016 10:25:32 +0200
Subject: [PATCH -next] clk: sunxi: pll2: Fix return value check in
 sun4i_pll2_setup()
In-Reply-To: <1467807514-31723-1-git-send-email-weiyj_lk@163.com>
References: <1467807514-31723-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160709082532.GG4522@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 12:18:34PM +0000, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the functions clk_register_composite() and
> clk_register_divider() returns ERR_PTR() and never returns NULL.
> The NULL test in the return value check should be replaced with
> IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thanks
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160709/9d6fff52/attachment.sig>
