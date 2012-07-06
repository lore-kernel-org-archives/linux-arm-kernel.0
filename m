From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:25:00 +0200
Subject: [PATCH 9/9] ARM: ux500: Over-ride the DT device naming scheme for
 pinctrl
In-Reply-To: <1341493572-29735-10-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda_-3r1=S1mJfFYwN4f5SOMD1_A62BhqhM0T-mQEjnTeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When pin control mapping tables are written the registered device
> name is supplied for use in name-based searches within the pinctrl
> driver. In the case of the DB8500 the string "pinctrl-db8500" is
> used. However, when we register the driver with Device Tree, its
> naming convention uses something that looks more like "pinctrl.2".
>
> To work around the device naming inconsistencies between devices
> registered via platform code and the ones registered by Device
> Tree, we use AUXDATA to over-ride the Device Tree naming scheme.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

But I guess it won't work without the patch that Rob is herding.
So maybe that patch should go in with this one.

Yours,
Linus Walleij
