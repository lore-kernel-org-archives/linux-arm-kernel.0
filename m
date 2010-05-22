From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 22 May 2010 01:49:06 -0600
Subject: [PATCH v7 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100522072755.GB18613@gw.healthdatacare.com>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<3729cd3650f5af6aebfc5bae02ff6aad1b9b1e82.1273120206.git.mika.westerberg@iki.fi>
	<20100522072755.GB18613@gw.healthdatacare.com>
Message-ID: <AANLkTimpImoDkTtsEN0AHEK6L-txuPCVK1ZPs5f14aeq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 1:27 AM, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> On Thu, May 06, 2010 at 07:47:04AM +0300, Mika Westerberg wrote:
>> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>> in EP93xx chips.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> Cc: David Brownell <dbrownell@users.sourceforge.net>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Martin Guy <martinwguy@gmail.com>
>
> Hi Grant,
>
> Ping. Any change getting this driver into .35? Platform side code
> is already in linux-next.

That is my plan.

g.
