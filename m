From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 14:02:41 +0200
Subject: [PATCH 0/3] serial: samsung: get fifosize from DT and clean up
In-Reply-To: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
References: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <53C669E1.90800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

On 14.07.2014 13:37, Naveen Krishna Chatradhi wrote:
> This patch set does the following
> 1: Get fifosize from DT node. But, not mandating it.
> 2. Corrects the case and default order in a switch
> 3. Defines a variable to simply the code.
> 
> Console messages on Exynos5420 based peach pit and pi works fine.
> 
> Naveen Krishna Chatradhi (3):
>   serial: samsung: get fifosize via device tree
>   serial: samsung: correct the case and default order in switch
>   serial: samsung: improve code clarity by defining a variable
> 
>  .../devicetree/bindings/serial/samsung_uart.txt    |    4 ++++
>  drivers/tty/serial/samsung.c                       |   19 +++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
