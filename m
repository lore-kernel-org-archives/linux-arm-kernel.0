From: anca.emanuel@gmail.com (Anca Emanuel)
Date: Wed, 12 Oct 2011 07:11:12 +0300
Subject: [PATCH v6 09/10] ARM: S5PC100: Modify platform data for pl330
	driver
In-Reply-To: <1318270538-30450-10-git-send-email-thomas.abraham@linaro.org>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-5-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-6-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-7-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-8-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-9-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-10-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAJL_dMvX-_ZpvJOUuD28RnoQpz6GFYiTvsWidfy3yeiu3Q04bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 9:15 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
<spnip>

> +u8 pdma1_peri[] = {
> + ? ? ? DMACH_UART0_RX,
> + ? ? ? DMACH_UART0_TX,
> + ? ? ? DMACH_UART1_RX,
> + ? ? ? DMACH_UART1_TX,
> + ? ? ? DMACH_UART2_RX,
> + ? ? ? DMACH_UART2_TX,
> + ? ? ? DMACH_UART3_RX,
> + ? ? ? DMACH_UART3_TX,
> + ? ? ? DMACH_IRDA,
> + ? ? ? DMACH_I2S0_RX,
> + ? ? ? DMACH_I2S0_TX,
> + ? ? ? DMACH_I2S0S_TX,
> + ? ? ? DMACH_I2S1_RX,
> + ? ? ? DMACH_I2S1_TX,
> + ? ? ? DMACH_I2S2_RX,
> + ? ? ? DMACH_I2S2_TX,
> + ? ? ? DMACH_SPI0_RX,
> + ? ? ? DMACH_SPI0_TX,
> + ? ? ? DMACH_SPI1_RX,
> + ? ? ? DMACH_SPI1_TX,
> + ? ? ? DMACH_SPI2_RX,
> + ? ? ? DMACH_SPI2_TX,
> + ? ? ? DMACH_PCM0_RX,
> + ? ? ? DMACH_PCM1_TX,

typo ?  DMACH_PCM0_TX

> + ? ? ? DMACH_PCM1_RX,
> + ? ? ? DMACH_PCM1_TX,
> + ? ? ? DMACH_MSM_REQ0,
> + ? ? ? DMACH_MSM_REQ1,
> + ? ? ? DMACH_MSM_REQ2,
> + ? ? ? DMACH_MSM_REQ3,
> ?};
