From: b32955@freescale.com (Huang Shijie)
Date: Fri, 4 May 2012 18:26:39 +0800
Subject: [PATCH 1/2] mtd: gpmi: add device tree support to gpmi-nand
In-Reply-To: <1336124510.4275.7.camel@sauron.fi.intel.com>
References: <1336101182-5200-1-git-send-email-b32955@freescale.com>
 <1336124510.4275.7.camel@sauron.fi.intel.com>
Message-ID: <4FA3AEDF.8010009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?05?04? 17:41, Artem Bityutskiy ??:
> On Fri, 2012-05-04 at 11:13 +0800, Huang Shijie wrote:
>> This patch just adds the DT support to gpmi-nand.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>> Please select the CONFIG_USE_OF before you do the compiler-test.
>> thanks.
> It should compile without CONFIG_USE_OF also just fine. Currently it
> does not.
>
why not select CONFIG_USE_OF as the gpmi-nand is converted to a DT driver.

If you insist that it should compile without CONFIG_USE_OF, i have to 
add back the header file ,
such as of_irq.h.

BR
Huang Shijie
