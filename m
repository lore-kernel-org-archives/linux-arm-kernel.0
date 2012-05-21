From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 09:06:54 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120518154725.GA10583@quad.lixom.net>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <20120516111744.GB9571@n2100.arm.linux.org.uk>
 <CACRpkdazMG1D6L6nWo330EWTZ_Fn6K0F5cjZSfMRGmk9OsaVXw@mail.gmail.com>
 <20120517104249.GI9571@n2100.arm.linux.org.uk>
 <20120518154725.GA10583@quad.lixom.net>
Message-ID: <CACRpkdbuCougOZML+egcmkTW4mkY4sJGLFJ2LX7_=hjZ9v_PMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 5:47 PM, Olof Johansson <olof@lixom.net> wrote:

> From cda9fbb62852a1b1fc0b1e77eec8b916d0f4d762 Mon Sep 17 00:00:00 2001
> From: Olof Johansson <olof@lixom.net>
> Date: Fri, 18 May 2012 08:43:39 -0700
> Subject: [PATCH] ARM: spear3xx: remove some zero initalizers
>
> Removing some unnecessary 0 initializers from platform pl08x platform
> data structures.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Oh Olof beats Viresh to the show, thanks!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
