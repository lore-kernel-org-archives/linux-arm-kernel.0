From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jan 2014 11:22:12 +0000
Subject: [PATCH RESEND 3/4] mfd: sec-core: Add cells for S5M8767-clocks
In-Reply-To: <1388053141-30085-4-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-4-git-send-email-tushar.behera@linaro.org>
Message-ID: <20140106112212.GP23772@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Dec 2013, Tushar Behera wrote:

> S5M8767 chip has 3 crystal oscillators running at 32KHz. These are
> supported by s2mps11-clk driver.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> CC: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/sec-core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
