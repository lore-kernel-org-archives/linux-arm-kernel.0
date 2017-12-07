From: david@lechnology.com (David Lechner)
Date: Thu, 7 Dec 2017 11:15:02 -0600
Subject: [PATCH v3] ARM: da850: Fix LEGO EV3 battery voltage gpio
In-Reply-To: <1b2fe02d-1c8f-e4e8-53b6-692c4545faf6@ti.com>
References: <1512338693-16781-1-git-send-email-david@lechnology.com>
 <1b2fe02d-1c8f-e4e8-53b6-692c4545faf6@ti.com>
Message-ID: <0073467e-29d0-9b76-1caa-1605d5897321@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2017 01:35 AM, Sekhar Nori wrote:
> On Monday 04 December 2017 03:34 AM, David Lechner wrote:
>> This fixes the battery voltage monitoring gpio-hog settings.
>>
>> When the gpio is low, it turns off the battery voltage to the ADC chip.
>> However, this needs to be on all of the time so that we can monitor
>> battery voltage.
>>
>> Also, there was a typo that prevented pinmuxing from working correctly.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Applied to fixes with subject line changed to:
> 
> ARM: dts: da850-lego-ev3: Fix battery voltage gpio
> 
> Please follow this style for future patches.

Ack
