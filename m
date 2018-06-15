From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 15 Jun 2018 08:09:14 +0200
Subject: [PATCH 2/2] arm: multi_v7_defconfig: Enable KSM.
In-Reply-To: <1529016629-2948-2-git-send-email-daniel.diaz@linaro.org>
References: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
 <1529016629-2948-2-git-send-email-daniel.diaz@linaro.org>
Message-ID: <CAMuHMdXp-Sh6pUNsWHk9UaYLbb4uLoeFoSPrBXm-sYDS-ptHiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for your patch!

On Fri, Jun 15, 2018 at 12:52 AM Daniel D?az <daniel.diaz@linaro.org> wrote:
> As per the documentation, Kernel Samepage Merging (available
> since 2.6.32) is a memory-saving de-duplication feature,
> enabled by CONFIG_KSM=y and activated via sysfs. More
> information can be found here:
>   https://www.kernel.org/doc/Documentation/vm/ksm.txt
>
> When enabled in the kernel, the default is to not do anything
> at all, until it is activated at run-time with:
>   echo 1 > /sys/kernel/mm/ksm/run

So that's the "what" part.

Why is it good to have this in multi_v7_defconfig, which is meant to ease
(compile)testing for as many supported ARM v7 SoCs as possible?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
