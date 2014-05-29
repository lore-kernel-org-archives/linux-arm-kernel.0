From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 May 2014 11:44:54 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <537E7B83.4020900@gmail.com>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <201405091244.02066.arnd@arndb.de>
 <CACRpkdb8c=k3Ky=TisNdzycc3owJsNSQmSTu03RR5E0QvE0KZA@mail.gmail.com>
 <537E7B83.4020900@gmail.com>
Message-ID: <CACRpkdap1U19EiULnq11udhY91UnnNu_-5MnLby3idbdjzBj4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 12:34 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 05/22/2014 09:41 AM, Linus Walleij wrote:

>> So for now I keep to our special driver.
>
> +1 for drivers/soc _and_ of_xlate for regmap instead of syscon.
>
> driven by Mike Turquette's request to join mach-berlin clock node into a
> single node, we currently use pinctrl driver (that must be somewhere in
> Linus inbox) as a crutch to register a regmap for other drivers.

I've merged it actually, I think. Else hit me on any missed patches.

> With a drivers/soc we'd have a good place for those messy, SoC-specific
> registers to put a driver that hooks up to a single node and takes care
> of registering e.g. pinctrl and reset the plain-old platform_device
> way. It will be a little bit like arm/mach-foo before, but maybe we
> have to admit that on SoCs there will always be some amount of
> very specific, non-probable, non-describable registers that simply need
> special treatment.

Hmmmm well I want to see that code before I believe it ... but
I get what you mean.

Yours,
Linus Walleij
