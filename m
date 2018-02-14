From: d.schultz@phytec.de (Daniel Schultz)
Date: Wed, 14 Feb 2018 16:32:44 +0100
Subject: [PATCH 1/3] ARM: dts: rockchip: phycore: Remove 1.8 GHz operation
 point
In-Reply-To: <7871181.EPqc8gR4GV@diego>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
 <7871181.EPqc8gR4GV@diego>
Message-ID: <a8de3d85-c4e6-eed6-d2e3-6d9b7318a9c2@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/14/2018 09:07 AM, Heiko St?bner wrote:
> Am Dienstag, 13. Februar 2018, 10:44:32 CET schrieb Daniel Schultz:
>> Rockchip recommends to run the CPU cores only with operations points of
>> 1.6 GHz or lower.
>>
>> Removed the cpu0 node with too high operation points and use the default
>> values instead.
>>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> applied all 3 for 4.17
>
Thanks! I think I should have mentioned this earlier, but can you please add
 ??? ARM: dts: rockchip: phycore: Remove 1.8 GHz operation point
to the stable tree v4.14?

-- 
Mit freundlichen Gr??en,
With best regards,
   Daniel Schultz
