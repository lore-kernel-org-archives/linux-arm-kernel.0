From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 20 Sep 2016 10:31:08 +0530
Subject: [PATCH v2 3/6] phy: meson: add USB2 PHY support for Meson8b and
 GXBB
In-Reply-To: <m2wpi7hmdt.fsf@baylibre.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
 <20160911134111.31141-4-martin.blumenstingl@googlemail.com>
 <m2a8faxy72.fsf@baylibre.com> <57DCC3CF.9090409@ti.com>
 <m2wpi7hmdt.fsf@baylibre.com>
Message-ID: <57E0C294.50502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 19 September 2016 10:12 PM, Kevin Hilman wrote:
> Kishon Vijay Abraham I <kishon@ti.com> writes:
> 
>> Hi Kevin,
>>
>> On Wednesday 14 September 2016 09:36 PM, Kevin Hilman wrote:
>>> Kishon,
>>>
>>> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>>>
>>>> This is a new driver for the USB PHY found in Meson8b and GXBB SoCs.
>>>>
>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>>>
>>> Will you be picking this up for v4.9?
>>
>> It's already late for 4.9. Generally send pull request to Greg around -rc6.
>> This can go only in 4.10.
> 
> That's fine.
> 
> Does that mean you have it queued someplace?  I don't see it in any of
> your branches.

I haven't queued so far. I'll create a testing branch to queue pending patches.

Thanks
Kishon
