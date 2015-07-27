From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Jul 2015 13:55:06 +0200
Subject: [PATCH 1/4][v4] ARM: imx: imx7d-pinfunc: add gpio pad iomuxc
 settings
In-Reply-To: <20150717035115.GE12927@tiger>
References: <1437078887-2524-1-git-send-email-aalonso@freescale.com>
 <20150717035115.GE12927@tiger>
Message-ID: <CACRpkda9JjZZ0=qEajeR7dxPUy1bcXXB+VDy=QnnG_ifC_aV0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 5:51 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Jul 16, 2015 at 03:34:44PM -0500, Adrian Alonso wrote:
>> * Add iMX7D SoC imx7d-pinfunc gpio pad settings
>>   <mux_reg conf_reg input_reg mux_mode input_val>
>> * iMX7D GPIO1_IO7 to GPIO1_IO0 encode the pad group id in the most
>>   significant bits of input_val to avoid group id overlap bweeten
>>   iomuxc and iomuxc-lpsr.
>>
>> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
>
> Unless you can convince me that this approach which hacks select input
> value is better than two instances one, it's an NACK for me on the whole
> patch series.

I'm dropping this patch series until this is resolved.

Yours,
Linus Walleij
