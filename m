From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:51:06 +0900
Subject: [PATCH 00/13] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support
In-Reply-To: <20150126002215.GB4477@verge.net.au>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150126002215.GB4477@verge.net.au>
Message-ID: <CANqRtoR+=xkMQFC61ak36=OTBi-TEjvHOhESdKo7w=bo7aVUvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jan 26, 2015 at 9:22 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jan 21, 2015 at 01:52:56PM +0900, Magnus Damm wrote:
>> ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support
>>
>> [PATCH 01/13] ARM: shmobile: mackerel: Remove ZBOOT code
>> [PATCH 02/13] ARM: shmobile: mackerel: Remove Legacy C board code
>> [PATCH 03/13] ARM: shmobile: mackerel dts: Remove Legacy DTS file
>> [PATCH 04/13] ARM: shmobile: mackerel: Remove DT binding documentation
>> [PATCH 05/13] ARM: shmobile: mackerel: Remove mach-type entry
>> [PATCH 06/13] ARM: shmobile: mackerel: Remove defconfig
>> [PATCH 07/13] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
>> [PATCH 08/13] ARM: shmobile: sh7372: Remove Legacy C SoC code
>> [PATCH 09/13] ARM: shmobile: sh7372: Remove DT binding documentation
>> [PATCH 10/13] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
>> [PATCH 11/13] Documentation: Remove ZBOOT MMC/SDHI utility and docs
>> [PATCH 12/13] pinctrl: sh-pfc: sh7372: Remove PFC support
>> [PATCH 13/13] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
>>
>> Remove legacy board and SoC support for Mackerel and sh7372. Both the
>> ARM mach-shmobile code base and the PINCTRL subsystem is affected.
>>
>> Also get rid of the remaining ZBOOT MMC/SDHI code, documentation and
>> utility that has no user once sh7372 is gone.
>>
>> The Cortex-A8 based sh7372 SoC is rather old and never went into mass
>> production anyway, so these patches that remove SoC and board support
>> will only affect a few selected developers.
>>
>> I wish we had some way to make use of the ZBOOT MMC/SDHI code, but
>> without any board or SoC code it makes little sense to keep it.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Hi Magnus,
>
> thanks for putting this together. There seem to have been few comments
> made on it. Could you consider respinning accordingly?

Done! V2 is now out.

Please let me know if you need to to rework something.

Cheers,

/ magnus
