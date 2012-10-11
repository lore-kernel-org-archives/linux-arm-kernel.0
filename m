From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Thu, 11 Oct 2012 17:24:25 +0200
Subject: [PATCH] Boottime: A tool for automatic measurement of
 kernel/bootloader boot time
In-Reply-To: <1349966545-19340-1-git-send-email-lee.jones@linaro.org>
References: <1349966545-19340-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAH9NwWe+s1p73Jwa=s5aY_KjGS2nvP8LR2YH3i5gtpFMUYMiuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/11 Lee Jones <lee.jones@linaro.org>:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
>
> The overhead is very low and the results will be found under
> sysfs/bootime, as well as detailed results in debugfs under
> boottime/. The bootgraph* files are compatible with
> scripts/bootgraph.pl. The reason for this patch is to provide
> data (sysfs/boottime) suitable for automatic testcases as
> well as help for developers to reduce the boot time (debugfs).
>

Nice idea... what about x86?
---
Christian Gmeiner, MSc
