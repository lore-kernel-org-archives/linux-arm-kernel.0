From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 13 Jun 2013 11:34:58 +0530
Subject: [PATCH v2 3/3] ARM: s5p64x0: Use common uncompress.h part for
 plat-samsung
In-Reply-To: <1370319552-17694-4-git-send-email-tushar.behera@linaro.org>
References: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
 <1370319552-17694-4-git-send-email-tushar.behera@linaro.org>
Message-ID: <51B9610A.20202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 09:49 AM, Tushar Behera wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Since uart_base can be set dynamically in arch_detect_cpu(), there is no
> need to have a copy of all code locally, just to override UART base
> address.
> 
> This patch removes any duplicate code in uncompress.h variant of s5p64x0
> and implements proper arch_detect_cpu() function to initialize UART with
> SoC-specific parameters.
> 
> While at it, replace hard-coded register address with macro.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> (This patch replaces the original patch in this patchset as it was an
> earlier-posted near-identical patch.)
> 
> Changes for v2:
> * Remove the declaration of uart_base (taken care in plat/uncompress.h)
> 

Kukjin,

Would you please queue this up for 3.11?

Thanks.

-- 
Tushar Behera
