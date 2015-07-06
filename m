From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 06 Jul 2015 11:06:22 +0200
Subject: [RFC PATCH 1/3] arm: psci: rename psci_smp.c to psci.c
In-Reply-To: <1436014910-1201-2-git-send-email-jszhang@marvell.com>
References: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
 <1436014910-1201-2-git-send-email-jszhang@marvell.com>
Message-ID: <559A450E.50801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2015 03:01 PM, Jisheng Zhang wrote:
> This will prepare for next commit to enable PSCI for UP systems so that
> calls like cpu_suspend can be made functional on UP too.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   arch/arm/kernel/Makefile   |   2 +-
>   arch/arm/kernel/psci.c     | 130 +++++++++++++++++++++++++++++++++++++++++++++
>   arch/arm/kernel/psci_smp.c | 130 ---------------------------------------------
>   3 files changed, 131 insertions(+), 131 deletions(-)
>   create mode 100644 arch/arm/kernel/psci.c
>   delete mode 100644 arch/arm/kernel/psci_smp.c

When you move or rename a file, use the -M option with git when sending 
the email. Instead of providing a big diff file, it will just annotate 
the renaming.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
