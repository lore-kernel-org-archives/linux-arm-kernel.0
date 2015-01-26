From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:49:51 +0900
Subject: [PATCH 00/13] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support
In-Reply-To: <3040234.j4M7Dsju9X@avalon>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <3040234.j4M7Dsju9X@avalon>
Message-ID: <CANqRtoQOB7NHf8PSUxidX+Q0KAHidJOAq1bp-h3ftAWf4LJF_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Jan 21, 2015 at 9:42 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patches.
>
> On Wednesday 21 January 2015 13:52:56 Magnus Damm wrote:
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
> For patches 01 to 05, 07 to 10, and 13,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Great, thanks, I have included your ack in V2 for the patches above.

> 'git grep -i sh7372' reports 25 mentions of the SoC in the kernel sources.
> Please let me know if you would like to me submit patches to remove them, or
> if you want to do so yourself.

Thanks. I prefer not to touch those myself, so if you or someone else
could do it step-by-step then that would be excellent.

Best,

/ magnus
