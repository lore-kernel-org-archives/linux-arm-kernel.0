From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 5 Jul 2017 15:02:26 +0800
Subject: [PATCH] ARM: dts: exynos: remove num-slots from exynos platforms
In-Reply-To: <20170705045126.GA2360@kozik-book>
References: <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
 <20170705045126.GA2360@kozik-book>
Message-ID: <f42e6cc1-bac4-6ab7-70a7-323d4734837d@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzystof,

On 2017/7/5 12:51, Krzysztof Kozlowski wrote:
> On Tue, Jul 04, 2017 at 05:25:22PM +0800, Shawn Lin wrote:
>> dwmmc driver deprecated num-slots and plan to get rid
>> of it finally. Just move a step to cleanup it from DT.
>>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> I do not see this property deprecated here (yesterday's next):
> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> Something is not merged yet?

The patch for dwmmc was queued for v4.13 already but the changes for Doc
was missing somehow. Will fix this later. Thanks for catching this.

> 
> Also in separate patch, please update example here:
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt

Ok.

BTW, will you pick this up now or you want me to resend
these two patches appending a new patch for exynos-dw-mshc.txt?

> 
> Best regards,
> Krzysztof
> 
> 
> 
> 
