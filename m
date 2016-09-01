From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Sep 2016 21:54:14 +0200
Subject: [PATCH] clk: sunxi-ng: mark ccu_nk_find_best() static
In-Reply-To: <1472727108-18388-1-git-send-email-baoyou.xie@linaro.org>
References: <1472727108-18388-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20160901195414.GH20462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 01, 2016 at 06:51:48PM +0800, Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/clk/sunxi-ng/ccu_nk.c:17:6: warning: no previous prototype for 'ccu_nk_find_best' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> So this patch marks it 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

A similar patch has been merged already.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/e2f1f1f1/attachment-0001.sig>
