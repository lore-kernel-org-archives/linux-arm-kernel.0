From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 25 Oct 2016 14:14:25 +0200
Subject: [PATCH/RFT v2 06/17] ARM: davinci: da8xx: Fix some redefined
 symbol warnings
In-Reply-To: <9fa01842-cf8e-87e9-75ce-5d4b2841fdfe@ti.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-7-ahaslam@baylibre.com>
 <9fa01842-cf8e-87e9-75ce-5d4b2841fdfe@ti.com>
Message-ID: <0d8e4d79-a8f4-9cad-cc52-7aa5ae49998e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2016 12:03 PM, Sekhar Nori wrote:
> On Monday 24 October 2016 10:16 PM, ahaslam at baylibre.com wrote:
>> From: Alexandre Bailon <abailon@baylibre.com>
>>
>> Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
>> but da8xx-cfgchip.h intend to replace them.
>> The usb-da8xx.c is using both headers, causing redefined symbol warnings.
>> Remove the old macros.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> 
> This is a v4.9-rc bug fix. Can you please post it as a separate patch
> for Greg to pick up?
> 
Done
> You can add:
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
Actually, I didn't add it because I had to make few changes to
submit as a separate patch. I hope I did it in right way.
> 
> Thanks,
> Sekhar
> 
Thanks,
Alexandre
