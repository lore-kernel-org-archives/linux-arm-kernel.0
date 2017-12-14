From: stefan.mavrodiev@gmail.com (Stefan Mavrodiev)
Date: Thu, 14 Dec 2017 08:24:54 +0200
Subject: [PATCH 1/1] arm: sunxi: Add alternative pins for spi0
In-Reply-To: <20171213154035.qc655iahjoeflftq@flea.lan>
References: <1513151074-6888-1-git-send-email-stefan@olimex.com>
 <20171213154035.qc655iahjoeflftq@flea.lan>
Message-ID: <5f518e4b-e624-17c2-7e72-24ba930a1c15@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2017 05:40 PM, Maxime Ripard wrote:
> Hi,
>
> On Wed, Dec 13, 2017 at 09:44:34AM +0200, Stefan Mavrodiev wrote:
>> Allwinner A10/A13/A20 SoCs have pinmux for spi0
>> on port C. The patch adds these pins in the respective
>> dts includes.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> Do you have any boards that are using these?
>
> We won't merge that patch if there's no users for it.
>
> Maxime
>
A20-OLinuXino-Lime/Lime2 and A10-OLinuXino-Lime with spi flash.
For A13 we still doesn't have that option.
