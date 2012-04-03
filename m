From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Apr 2012 22:49:13 +0200
Subject: [PATCH 08/11] ARM: tegra: Switch to new pinctrl driver
In-Reply-To: <1333148404-17691-9-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
 <1333148404-17691-9-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdaQ2owAFxpF-F2t8m2MUEx0CY1gjvwUA1JGLJ6UOci30g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 1:00 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> ---
> v3: Remove GPIO-related code, use mapping table instead of pinctrl APIs
> ? ?for all pinconfig setup. Don't tristate PCIe pingroups on Harmony.
> ? ?Note: Before this version, this patch had the following acks, but I've
> ? ?removed them due to the rework:
> ? ?Linus Walleij <linus.walleij@linaro.org>
> ? ?Olof Johansson <olof@lixom.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this goes through the Tegra tree,
Linus Walleij
