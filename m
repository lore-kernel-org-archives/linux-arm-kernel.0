From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:40:32 +0100
Subject: [PATCH v2 1/9] ARM: centralize common multi-platform kconfig
 options
In-Reply-To: <1392153119-23248-2-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-2-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdb5DzXbFV=mH24HuyGQ91OjPYx5=bMeNSb+xQ8q4epGiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 10:11 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Multi-platform requires various kconfig options to be selected, so
> platforms don't need to select them individually.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>

OK makes sense. Maybe a bit unintuitive that multiplat
make gpiolib wanted optional and then platforms override
this by requiring it, but whatever, I cannot think of anything
better.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
