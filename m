From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Oct 2011 13:52:12 +0900
Subject: [PATCH v6 09/10] ARM: S5PC100: Modify platform data for pl330
	driver
In-Reply-To: <CAJuYYwSj4D1bMbUtaPe=33GrS=e1_7+POHRWCb8Yzgpv8_Muzg@mail.gmail.com>
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
	<CAJuYYwSj4D1bMbUtaPe=33GrS=e1_7+POHRWCb8Yzgpv8_Muzg@mail.gmail.com>
Message-ID: <063501cc889a$b52eb520$1f8c1f60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> Hi Anca,
> 
> On 12 October 2011 09:41, Anca Emanuel <anca.emanuel@gmail.com> wrote:
> > On Mon, Oct 10, 2011 at 9:15 PM, Thomas Abraham
> > <thomas.abraham@linaro.org> wrote:
> > <spnip>
> >
> >> +u8 pdma1_peri[] = {
> >> + ? ? ? DMACH_UART0_RX,
> >> + ? ? ? DMACH_UART0_TX,
> >> + ? ? ? DMACH_UART1_RX,
> >> + ? ? ? DMACH_UART1_TX,
> >> + ? ? ? DMACH_UART2_RX,
> >> + ? ? ? DMACH_UART2_TX,
> >> + ? ? ? DMACH_UART3_RX,
> >> + ? ? ? DMACH_UART3_TX,
> >> + ? ? ? DMACH_IRDA,
> >> + ? ? ? DMACH_I2S0_RX,
> >> + ? ? ? DMACH_I2S0_TX,
> >> + ? ? ? DMACH_I2S0S_TX,
> >> + ? ? ? DMACH_I2S1_RX,
> >> + ? ? ? DMACH_I2S1_TX,
> >> + ? ? ? DMACH_I2S2_RX,
> >> + ? ? ? DMACH_I2S2_TX,
> >> + ? ? ? DMACH_SPI0_RX,
> >> + ? ? ? DMACH_SPI0_TX,
> >> + ? ? ? DMACH_SPI1_RX,
> >> + ? ? ? DMACH_SPI1_TX,
> >> + ? ? ? DMACH_SPI2_RX,
> >> + ? ? ? DMACH_SPI2_TX,
> >> + ? ? ? DMACH_PCM0_RX,
> >> + ? ? ? DMACH_PCM1_TX,
> >
> > typo ? ?DMACH_PCM0_TX
> 
> Yes. That is a mistake. I cross-checked others with the user manual
> and they are fine.
> 

OK, I think you don't need to re-send because I can fix it when I apply.
It would be helpful to me if you could check your patches again :)

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> Thanks for pointing this out.
> 
> >
> >> + ? ? ? DMACH_PCM1_RX,
> >> + ? ? ? DMACH_PCM1_TX,
> >> + ? ? ? DMACH_MSM_REQ0,
> >> + ? ? ? DMACH_MSM_REQ1,
> >> + ? ? ? DMACH_MSM_REQ2,
> >> + ? ? ? DMACH_MSM_REQ3,
> >> ?};
> >
