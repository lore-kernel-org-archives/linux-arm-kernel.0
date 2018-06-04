From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 4 Jun 2018 07:12:33 +0100
Subject: [PATCH 2/2] pwm: stm32: initialize raw local variables
In-Reply-To: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180604061233.GC25455@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2018, Fabrice Gasnier wrote:

> This removes build warning when COMPILE_TEST=y and MFD_STM32_TIMERS=n
> in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
> 'raw_dty' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
