From: balajitk@ti.com (Balaji T K)
Date: Fri, 11 Oct 2013 22:14:34 +0530
Subject: [PATCH v2 1/2] ARM: dts: dra7-evm: Add mmc1 node for micro-sd
 support
In-Reply-To: <5255A59C.5040301@ti.com>
References: <1381163104-6318-1-git-send-email-balajitk@ti.com>
 <5255A59C.5040301@ti.com>
Message-ID: <52582AF2.6070502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 October 2013 12:21 AM, Sekhar Nori wrote:
> On Monday 07 October 2013 09:55 PM, Balaji T K wrote:
>> Add mmc1 dt node to dra7-evm board.
>> Input for ldo1 regulator is controlled by gpio 5 of pcf8575 chip (0x21)
>> on i2c1 bus. When dt support for gpio-pcf857x is available, input supply
>> will be modelled as cascaded regulator.
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
>
Hi Benoit,

Can you let me know if you have any comments on this patch series?

Thanks and Regards
Balaji T K
