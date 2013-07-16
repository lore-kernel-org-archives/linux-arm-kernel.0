From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Jul 2013 14:22:37 +0200
Subject: [PATCH -next] clk: sunxi: fix return value check
In-Reply-To: <CAPgLHd_RTeUgZtsLd=GqW7tG0q-ccDcd8gBNgDxo3E8qLE141g@mail.gmail.com>
References: <CAPgLHd_RTeUgZtsLd=GqW7tG0q-ccDcd8gBNgDxo3E8qLE141g@mail.gmail.com>
Message-ID: <20130716122237.GF3125@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On Tue, Jul 16, 2013 at 08:17:45PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_register_composite() and
> clk_register_factors() returns ERR_PTR() not NULL. The NULL test
> in the return value check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for this patch, but Axel Lin already sent a equivalent patch for
this issue last week:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/183138.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/db544376/attachment.sig>
