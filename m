From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Jun 2015 18:21:25 +0200
Subject: [PATCH] drivers/clk: convert sunxi/clk-mod0.c to use
 builtin_platform_driver
In-Reply-To: <1433358578-9579-1-git-send-email-paul.gortmaker@windriver.com>
References: <1431287385-1526-1-git-send-email-paul.gortmaker@windriver.com>
 <1433358578-9579-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20150604162125.GN23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 03:09:38PM -0400, Paul Gortmaker wrote:
> This driver builds based on obj-y and hence will not ever be
> modular.  Change it to use the non-modular registration so that it
> won't suffer a compile fail once a header move places the modular
> registration within the module.h file.
> 
> Cc: "Emilio L?pez" <emilio@elopez.com.ar>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-clk at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/0ba0c04a/attachment.sig>
