From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:22:01 +0200
Subject: [PATCH 6/8] mfd: Use interrupt-parent as IRQ controller if
 specified in DT
In-Reply-To: <1344527635-6163-7-git-send-email-lee.jones@linaro.org>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ9sVEM08HkZWnVCLt9kZ2NX-Fk+Jy_AZ65P3vSWk_UGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Without this patch the default behaviour is to climb the Device
> Tree and use the first encountered interrupt controller. This
> does not take into account if a device node has specified to use
> a particular IRQ controller using the interrupt-parent property.
> This patch ensures that property is adhered to.
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Mark & Rob may want to check this out too.

Yours,
Linus Walleij
