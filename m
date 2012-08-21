From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Aug 2012 14:54:16 +0200
Subject: [PATCH 1/2] ARM: dts: Add pinctrl node entries for Samsung
 Exynos4210 SoC
In-Reply-To: <1345061442-32378-2-git-send-email-thomas.abraham@linaro.org>
References: <1345061442-32378-1-git-send-email-thomas.abraham@linaro.org>
 <1345061442-32378-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkdbuqtPKMTEziPfMYfSssjWxPeMEP7=wJD4WtEHNppcOZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:10 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> +       pinctrl at 11400000 {
> +               uart0_data: uart0-data {
> +                       samsung,pins = "gpa0-0", "gpa0-1";
> +                       samsung,pin-function = <0x2>;
> +                       samsung,pin-pud = <0>;
> +                       samsung,pin-drv = <0>;
> +               };

Apart from the pin-pud and pin-drv stuff this patch looks fine. These two
things I want to discuss in the other mail thread (controller core) first.

Yours,
Linus Walleij
