From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Mar 2018 14:24:46 -0700
Subject: [PATCH] ARM: bcm2835: Add the DPI hardware to the device tree.
In-Reply-To: <258037433.356163.1520876736286@email.1und1.de>
References: <20180309233639.2029-1-eric@anholt.net>
 <258037433.356163.1520876736286@email.1und1.de>
Message-ID: <fbfe832f-3253-277a-2b8a-a159cd323052@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2018 10:45 AM, Stefan Wahren wrote:
>> Eric Anholt <eric@anholt.net> hat am 10. M?rz 2018 um 00:36 geschrieben:
>>
>>
>> It's currently marked disabled, as it's not useful without a panel
>> associated with it and the GPIO pins routed to ALT2.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
> 
> FWIW, Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Eric, do you want me to apply that directly to my upcoming ARM SoC pull
request (next couple of days)?
-- 
Florian
