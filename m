From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 15:13:27 +0100
Subject: [PATCH 4/9] arm/pxa2xx: reorgazine SSP and SPI header files
In-Reply-To: <AANLkTinBFQZkuH4haeQAZQv8p0WZN5uh4xJj53sjUGTt@mail.gmail.com>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>	<1290597207-29838-5-git-send-email-bigeasy@linutronix.de>
	<AANLkTinBFQZkuH4haeQAZQv8p0WZN5uh4xJj53sjUGTt@mail.gmail.com>
Message-ID: <4CED1D87.3000607@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote:
> On Wed, Nov 24, 2010 at 7:13 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
<snip>
>> diff --git a/arch/arm/plat-pxa/include/plat/ssp.h b/include/linux/pxa2xx_ssp.h
>> similarity index 98%
>> rename from arch/arm/plat-pxa/include/plat/ssp.h
>> rename to include/linux/pxa2xx_ssp.h
>> index 21c12ca..84465d4 100644
>> --- a/arch/arm/plat-pxa/include/plat/ssp.h
>> +++ b/include/linux/pxa2xx_ssp.h
> Is there any reason to rename ssp.h?

Yup. It ends up in a global include/linux folder so just ssp may get
confused with something else. I didn't move it into the spi folder because
it isn't really spi and it is also used by the sound driver.

Sebastian
