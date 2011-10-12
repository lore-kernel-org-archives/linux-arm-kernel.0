From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 12 Oct 2011 10:04:34 +0530
Subject: [PATCH v6 09/10] ARM: S5PC100: Modify platform data for pl330
	driver
In-Reply-To: <CAJL_dMvX-_ZpvJOUuD28RnoQpz6GFYiTvsWidfy3yeiu3Q04bA@mail.gmail.com>
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
	<CAJL_dMvX-_ZpvJOUuD28RnoQpz6GFYiTvsWidfy3yeiu3Q04bA@mail.gmail.com>
Message-ID: <CAJuYYwSj4D1bMbUtaPe=33GrS=e1_7+POHRWCb8Yzgpv8_Muzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anca,

On 12 October 2011 09:41, Anca Emanuel <anca.emanuel@gmail.com> wrote:
> On Mon, Oct 10, 2011 at 9:15 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> <spnip>
>
>> +u8 pdma1_peri[] = {
>> + ? ? ? DMACH_UART0_RX,
>> + ? ? ? DMACH_UART0_TX,
>> + ? ? ? DMACH_UART1_RX,
>> + ? ? ? DMACH_UART1_TX,
>> + ? ? ? DMACH_UART2_RX,
>> + ? ? ? DMACH_UART2_TX,
>> + ? ? ? DMACH_UART3_RX,
>> + ? ? ? DMACH_UART3_TX,
>> + ? ? ? DMACH_IRDA,
>> + ? ? ? DMACH_I2S0_RX,
>> + ? ? ? DMACH_I2S0_TX,
>> + ? ? ? DMACH_I2S0S_TX,
>> + ? ? ? DMACH_I2S1_RX,
>> + ? ? ? DMACH_I2S1_TX,
>> + ? ? ? DMACH_I2S2_RX,
>> + ? ? ? DMACH_I2S2_TX,
>> + ? ? ? DMACH_SPI0_RX,
>> + ? ? ? DMACH_SPI0_TX,
>> + ? ? ? DMACH_SPI1_RX,
>> + ? ? ? DMACH_SPI1_TX,
>> + ? ? ? DMACH_SPI2_RX,
>> + ? ? ? DMACH_SPI2_TX,
>> + ? ? ? DMACH_PCM0_RX,
>> + ? ? ? DMACH_PCM1_TX,
>
> typo ? ?DMACH_PCM0_TX

Yes. That is a mistake. I cross-checked others with the user manual
and they are fine.

Thanks for pointing this out.

Regards,
Thomas.

>
>> + ? ? ? DMACH_PCM1_RX,
>> + ? ? ? DMACH_PCM1_TX,
>> + ? ? ? DMACH_MSM_REQ0,
>> + ? ? ? DMACH_MSM_REQ1,
>> + ? ? ? DMACH_MSM_REQ2,
>> + ? ? ? DMACH_MSM_REQ3,
>> ?};
>
