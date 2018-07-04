From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Jul 2018 12:05:29 +0530
Subject: [PATCH v3 00/13] ARM: davinci: remove duplicate aemif support
In-Reply-To: <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
References: <20180628095748.4462-1-brgl@bgdev.pl>
 <52a274f1-283a-a14a-54f3-4b95b6605c4f@ti.com>
 <59fdc532-bb72-ffae-cfb6-a7f156c14771@lechnology.com>
Message-ID: <e1222b3c-dfa4-4cb0-eebf-8e2550e9d674@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Monday 02 July 2018 09:02 PM, David Lechner wrote:
> On 07/02/2018 07:28 AM, Sekhar Nori wrote:
>> Hi David, Stephen,
>>
>> On Thursday 28 June 2018 03:27 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This series moves all aemif/nand users to using the ti-aemif platform
>>> driver located in drivers/memory instead of the older API located in
>>> mach-davinci.
>>>
>>> First five patches add necessary changes to the clock driver. Next
>>> seven convert the board files to using the ti-aemif driver. Last patch
>>> removes now dead code.
>>
>> How do you want to handle this series? I can apply the series and
>> provide you an immutable branch on v4.18-rc1 with the clock patches
>> applied if that can work.
> 
> Sounds good to me. But I'm new to this maintainer thing, so maybe
> there is something to consider that I haven't thought of?

I don't think there is more to it. Ultimately there should not be two
commits for the same patch. Either you can apply and share the commit to
use or I can do that as well. I am equally fine either way.

Regards,
Sekhar
