From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 4 Sep 2015 09:39:30 +0200
Subject: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAMuHMdUROhCFOLWqABY3G_VaOavz5crDsM4z6KkGcBOEQtXj_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 9:58 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Enable runtime PM for CPU devices. Do a runtime get of the CPU device
> when the CPU is hotplugged in and a runtime put of the CPU device when

s/in/on/

> the CPU is hotplugged off. When all the CPUs in a domain are hotplugged
> off, the domain may also be powered off and cluster_pm_enter/exit()
> notifications are be sent out.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
