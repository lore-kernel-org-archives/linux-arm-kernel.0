From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Sep 2016 12:32:28 +0200
Subject: [PATCH] rtc: constify rtc_class_ops structures
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZV6mF2XvY8DiV3GM8yksNLXiag4_i6EXaosSZAc784-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 10:05 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
(...)
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
