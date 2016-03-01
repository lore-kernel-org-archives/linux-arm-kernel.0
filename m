From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Feb 2016 23:13:44 -0800
Subject: [PATCH 1/8] drivers/pinctrl: sunxi/pinctrl-sunxi.c does not need
 module.h
In-Reply-To: <1456778924-20730-2-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
 <1456778924-20730-2-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20160301071344.GJ8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 03:48:37PM -0500, Paul Gortmaker wrote:
> This file is not modular, nor is it using modular functions. The
> only thing close is the global THIS_MODULE which comes from export.h
> so lets replace it appropriately and cut back on the amount of
> header stuff we draw in by several thousand lines.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/5a0cd778/attachment.sig>
