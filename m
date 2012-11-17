From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 17 Nov 2012 21:09:15 +0100
Subject: [PATCH 1/3] gpio: pca953x: Register an IRQ domain
In-Reply-To: <1352394113-19513-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1352394113-19513-1-git-send-email-maxime.ripard@free-electrons.com>
 <1352394113-19513-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdY0XWy3dnY5SogMFeYMyB4G00wKS-oJQAQLV6hcG-zNZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 8, 2012 at 6:01 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The PCA953x used to register no IRQ domain, which made it impossible to
> use it as an interrupt-parent from the device tree.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Hmmmmm will look over the use of the irqdomain but it's better
with this than without it so patch applied, thanks.

Yours,
Linus Walleij
