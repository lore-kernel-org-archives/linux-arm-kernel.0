From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 09 Jul 2016 09:45:52 +0200
Subject: [PATCH 5/5] rtc: v3020: move rtc-v3020.h to platform_data
In-Reply-To: <1466978583-13310-5-git-send-email-alexandre.belloni@free-electrons.com>
 (Alexandre Belloni's message of "Mon, 27 Jun 2016 00:03:03 +0200")
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1466978583-13310-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <87bn2745lb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:

> rtc-v3020.h belongs to include/linux/platform_data/
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: linux-arm-kernel at lists.infradead.org
>  arch/arm/mach-pxa/cm-x270.c                   | 2 +-
>  arch/arm/mach-pxa/cm-x300.c                   | 2 +-
>  arch/arm/mach-pxa/em-x270.c                   | 2 +-
>  drivers/rtc/rtc-v3020.c                       | 2 +-
>  include/linux/{ => platform_data}/rtc-v3020.h | 0
>  5 files changed, 4 insertions(+), 4 deletions(-)
>  rename include/linux/{ => platform_data}/rtc-v3020.h (100%)
For mach-pxa :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Is this going through your rtc tree, or should I pick it up through the pxa one ?

Cheers.

--
Robert
