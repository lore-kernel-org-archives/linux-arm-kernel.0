From: david@lechnology.com (David Lechner)
Date: Mon, 2 Jul 2018 10:32:01 -0500
Subject: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
In-Reply-To: <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
Message-ID: <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2018 07:28 AM, Sekhar Nori wrote:
> Hi David, Stephen,
> 
> On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This series moves all aemif/nand users to using the ti-aemif platform
>> driver located in drivers/memory instead of the older API located in
>> mach-davinci.
>>
>> First five patches add necessary changes to the clock driver. Next
>> seven convert the board files to using the ti-aemif driver. Last patch
>> removes now dead code.
> 
> How do you want to handle this series? I can apply the series and
> provide you an immutable branch on v4.18-rc1 with the clock patches
> applied if that can work.

Sounds good to me. But I'm new to this maintainer thing, so maybe
there is something to consider that I haven't thought of?
