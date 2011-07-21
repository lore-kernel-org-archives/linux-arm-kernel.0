From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 20 Jul 2011 17:31:24 -0700
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <20110720231638.GK6999@S2100-06.ap.freescale.net>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>	<1311167599-21790-1-git-send-email-shawn.guo@linaro.org>	<4E27444D.2010005@boundarydevices.com>
	<20110720231638.GK6999@S2100-06.ap.freescale.net>
Message-ID: <4E27735C.90906@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/20/2011 4:16 PM, Shawn Guo wrote:
> On Wed, Jul 20, 2011 at 02:10:37PM -0700, Troy Kisky wrote:
>> On 7/20/2011 6:13 AM, Shawn Guo wrote:
>>
>> So, all MX5's are using MX51_UART1_BASE_ADDR.
>> I can't see that your patch changes CONFIG_ARCH_MX5
>> to CONFIG_SOC_IMX51. It isn't functionally the same as my version.
>>
> We started from the difference base.  No, it is not functionally the
> same as yours, so even remove your reported-by? :)
> 

Thanks for the explanation. You'll get no complaints from me. Do as you
like.

Troy
