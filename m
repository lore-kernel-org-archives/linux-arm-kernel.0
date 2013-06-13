From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 13 Jun 2013 11:34:06 +0530
Subject: [PATCH v2 2/3] ARM: SAMSUNG: Consolidate uncompress subroutine
In-Reply-To: <1370319552-17694-3-git-send-email-tushar.behera@linaro.org>
References: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
 <1370319552-17694-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <51B960D6.7080901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 09:49 AM, Tushar Behera wrote:
> For mach-exynos, uart_base is a pointer and the value is calculated
> in the machine folder. For other machines, uart_base is defined as
> a macro in platform directory. For symmetry, the uart_base macro
> definition is removed and the uart_base calculation is moved to
> specific machine folders.
> 
> This would help us consolidating uncompress subroutine for s5p64x0.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> Changes for v2:
> * Remove ifdef's while calculating uart_base value.
> 

Kukjin,

Would you please queue this up for 3.11?

Thanks.

-- 
Tushar Behera
