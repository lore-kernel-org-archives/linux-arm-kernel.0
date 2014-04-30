From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Apr 2014 15:02:23 +0100
Subject: [PATCH 09/10] ARM: vexpress: move HBI check to sysreg driver
In-Reply-To: <1398707877-22596-10-git-send-email-pawel.moll@arm.com>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-10-git-send-email-pawel.moll@arm.com>
Message-ID: <20140430140223.GP29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The last reason for static memory mapping is the HBI (board
> identification number) check early in the machine code.
> 
> Moving the check to the sysreg driver makes it possible to
> completely remove the early mapping and init functions.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/mach-vexpress/v2m.c  | 49 -------------------------------------------
>  drivers/mfd/vexpress-sysreg.c | 30 ++++++++++----------------
>  include/linux/vexpress.h      |  1 -
>  3 files changed, 11 insertions(+), 69 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

How do you want this patch handled?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
