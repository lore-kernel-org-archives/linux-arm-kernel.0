From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Aug 2013 09:52:05 +0200
Subject: [PATCH] pinctrl: sunxi: drop lock on error path
In-Reply-To: <1377796784-31147-1-git-send-email-linus.walleij@linaro.org>
References: <1377796784-31147-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130830075205.GH4341@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Aug 29, 2013 at 07:19:44PM +0200, Linus Walleij wrote:
> I forgot to drop the lock for the return inside the loop
> protected by the spinlock in the pin config routine when
> merging in -rc7 in commit 6ad30ce046aefbdc3848232c665a728860d7bb68
> 
> Reported-by: Sherman Yin <syin@broadcom.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130830/b399863f/attachment.sig>
