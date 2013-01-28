From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 11:25:09 +0100
Subject: [PATCH v3 2/3] gpio: pca953x: add support for pca9505
In-Reply-To: <51045261.5020709@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
 <1358889025-8530-3-git-send-email-gregory.clement@free-electrons.com>
 <CACRpkda-N0GrKOeaz4Hji0ef9pSRNPCxW_jLGR28iX-sk0-=tg@mail.gmail.com>
 <51024422.2060503@free-electrons.com>
 <CACRpkdbe1fGVLNyJ+U+ozE32p+_fc-eQ4W1F8OeYC+fryu_dQQ@mail.gmail.com>
 <51045261.5020709@free-electrons.com>
Message-ID: <CACRpkdY+ZwO4CdfAV-DQkVVmG8b2Xi3zaFULNVaGWty6PiOccw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 11:02 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> I was about to fix the issues you have pointed but I didn't find anything like
>
> #ifdef CONFIG_ARCH_PXA
>         if (cpu_is_pxa25x()) {
> #ifdef CONFIG_CPU_PXA26x
>                 count = 89;
>                 gpio_type = PXA26X_GPIO;
> #elif defined(CONFIG_PXA25x)
>
> in the pca953x driver! I think you messed up with another patch set!

Yes I did.

Forget about this, thanks for the other nice patches!

Yours,
Linus Walleij
