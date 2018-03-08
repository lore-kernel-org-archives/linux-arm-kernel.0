From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 8 Mar 2018 20:51:07 +0530
Subject: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
In-Reply-To: <d4e745a6-5534-662e-f6d5-a91bf580f550@roeck-us.net>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
 <2628eff2-dd33-34f4-a7e1-cfe46ef88a3f@nvidia.com>
 <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
 <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
 <952cb50e-d9a0-ae5e-d9f6-d1ce268f0384@nvidia.com>
 <f7818e4c-17b6-c58b-3424-85749bb9c1cc@roeck-us.net>
 <5bffef40-a4a7-5f7d-a448-b2a381c57822@nvidia.com>
 <d4e745a6-5534-662e-f6d5-a91bf580f550@roeck-us.net>
Message-ID: <4d00a31b-44cc-d3dc-78a2-1b7f23d777e0@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 08 March 2018 08:01 PM, Guenter Roeck wrote:
> On 03/07/2018 10:06 PM, Laxman Dewangan wrote:
>>
>>
>> The RPM is measured speed via PWM signal capture  which is output 
>> from fan.
>> So should we have the fan[1..n]_output_rpm?
>>
>
> No. I hear you clearly that you for some reason dislike fan[1..n]_input.
> While ABIs are not always to our liking, that doesn't mean that we get
> to change them at our whim. If that is not acceptable for you, I can't
> help you. And you can't change inX_input to inX_voltage either, sorry.

My opinion is only to not use "input" as this is not really the input to 
fan.
