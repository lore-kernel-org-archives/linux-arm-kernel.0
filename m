From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Sep 2018 11:17:52 -0700
Subject: [PATCH] arm64: dts: broadcom: Use the .dtb name in the rule,
 rather than .dts
In-Reply-To: <539eb374-9122-6c09-4c64-80bfa6b7bf89@i2se.com>
References: <b42d2e57-8bcd-0d6a-7a4d-aeefedcdd5f3@i2se.com>
 <20180924102228.19656-1-liviu@dudau.co.uk>
 <539eb374-9122-6c09-4c64-80bfa6b7bf89@i2se.com>
Message-ID: <1c0db58a-5bc2-8de3-f70d-725a29376513@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2018 04:03 AM, Stefan Wahren wrote:
> Am 24.09.2018 um 12:22 schrieb Liviu Dudau:
>> Commit a7eb26392b893 ("arm64: dts: broadcom: Add reference to Compute
>> Module IO Board V3") adds the bcm2837-rpi-cm3-io3.dts file as a target
>> in the Makefile, rather than the .dtb name. This will skip the
>> generation of the .dtb file at compile time and will fail the dtbs_install
>> target.
>>
>> Fixes: a7eb26392b893 ("arm64: dts: broadcom: Add reference to Compute
>> Module IO Board V3")
>>
>> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Thanks, i will add a dtbs_install step to my test jobs.

Same here.

> 
> @Arnd @Olof Should this fix for 4.20 go via pull request or can you
> apply it directly to your tree?

That would be my preference here as well.
-- 
Florian
