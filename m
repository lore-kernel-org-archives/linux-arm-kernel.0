From: b32955@freescale.com (Huang Shijie)
Date: Tue, 2 Jul 2013 18:43:13 +0800
Subject: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
In-Reply-To: <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
 <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
Message-ID: <51D2AEC1.6030004@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?02? 17:56, Mark Rutland ??:
> On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
>> >  The imx6 uart can supports the DMA, imx uart driver has added a new
>> >  compatible property for the imx6 uart.
>> >  
>> >  In order to enable the DMA for some uart port in imx6, we rename the
>> >  uart's compatible property to "fsl,imx6-uart".
> Doesn't this change break using these dts with an older kernel? You
is it reasonable to use a new dts with an old kernel?


> remove the "fsl,imx21-uart" string older kernels understand.
>
> Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" strings,
> would it not have made more sense to just add these to the driver?
I think it's not a good idea.

Shawn, what's your opinion about this?

thanks
Huang Shijie
