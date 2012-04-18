From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:21:42 +0200
Subject: [PATCH 13&15/16 v2] ARM: ux500: Apply Device Tree settings for
 the DB8500 PRCMU
In-Reply-To: <4F8D9296.6020004@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-16-git-send-email-lee.jones@linaro.org>
 <4F8D9296.6020004@linaro.org>
Message-ID: <CACRpkdYXr7iZjpittkhJ6jyhxmMkbo06DPi2ZZAWfzj_JVbfGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 5:56 PM, Lee Jones <lee.jones@linaro.org> wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 17 Apr 2012 10:42:41 +0100
> Subject: [PATCH 1/2] mfd/db8500-prcmu: Add Device Tree support and enable
> ?ux500 platforms
>
> Here we see the db8500-prcmu driver obtain DT support. In its
> current state, all we have to do is offer a matching compatible
> node and the driver will register and initialise correctly. We
> Also remove any initialisation completed in platform code to
> prevent any device duplication.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

And this (while it looks OK) still needs to go through the
MFD tree or have Sam's ACK.

Yours,
Linus Walleij
