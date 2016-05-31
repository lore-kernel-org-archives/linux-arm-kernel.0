From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 10:31:16 +0200
Subject: [PATCH] pinctrl: digicolor: add missing platform_set_drvdata()
 call
In-Reply-To: <1464155932-25344-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464155932-25344-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZMZvV6fYsr0Dx8Fiu-W8uYrqK92tzHkMG4BOECRbbHkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 7:58 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> gc_pinctrl_remove() calls platform_get_drvdata(), but I see neither
> platform_set_drvdata() nor dev_set_drvdata() anywhere in this driver.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied with Baruch's ACK.

Yours,
Linus Walleij
