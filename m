From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Tue, 08 Jul 2014 19:09:02 +0300
Subject: [PATCH 3/3] ARM: msm: delete dangling debug UART code
In-Reply-To: <1404832303-14850-4-git-send-email-linus.walleij@linaro.org>
References: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
 <1404832303-14850-4-git-send-email-linus.walleij@linaro.org>
Message-ID: <53BC179E.5050000@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/08/2014 06:11 PM, Linus Walleij wrote:
> The config symbols CONFIG_MSM_DEBUG_UART1 and *UART3 are used
> in the Trout board code, but these symbols are not defined anywhere
> in the kernel so cleaning them out.
>
> This is not to be confused with CONFIG_DEBUG_MSM_UART1 and
> CONFIG_DEBUG_MSM_UART2 which do exist.
>

I have sent a similar patch: https://lkml.org/lkml/2014/5/26/406

Thanks,
Georgi
