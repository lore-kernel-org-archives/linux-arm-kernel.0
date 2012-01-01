From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Jan 2012 14:44:51 +0100
Subject: [PATCH v5 REPOST 1/5] ARM: l2x0/pl310: Refactor Kconfig to be
 more maintainable
In-Reply-To: <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-2-git-send-email-dave.martin@linaro.org>
Message-ID: <CACRpkdaZ8fph0tgQMceVKzSNo9gbsaRFrz9c2TKYqYZgtbgdbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 5:35 PM, Dave Martin <dave.martin@linaro.org> wrote:

> Making CACHE_L2X0 depend on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
(...)
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> ? ? ? ?(for cns3xxx)
> Acked-by: Tony Lindgren <tony@atomide.com>
> ? ? ? ?(for omap)
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ? ? ? ?(for imx)

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(for ux500)

Yours,
Linus Walleij
