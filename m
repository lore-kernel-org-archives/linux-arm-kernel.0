From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Nov 2013 08:52:18 +0000
Subject: [PATCH 2/2] clksrc: delete nomadik MTU non-DT boot path
In-Reply-To: <528BE9C1.8000409@linaro.org>
References: <1384896499-9428-1-git-send-email-linus.walleij@linaro.org>
 <528BE9C1.8000409@linaro.org>
Message-ID: <20131120085218.GE19953@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013, Daniel Lezcano wrote:

> On 11/19/2013 10:28 PM, Linus Walleij wrote:
> >Both platforms using the MTU (Nomadik and Ux500) have now been
> >converted to use device tree exclusively, thus let us delete
> >this platform data header and make this driver a fully
> >self-contained DT-only driver.
> >
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Lee Jones <lee.jones@linaro.org>
> >Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> A sidenote: there is a comment in arch/arm/mach-ux500/timer.c
> "/* TODO: Once MTU has been DT:ed place code above into else. */"
> but I did not see any changes related to this TODO.

You mean similar to this one:
  https://lkml.org/lkml/2013/11/6/118

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
