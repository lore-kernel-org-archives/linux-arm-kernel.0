From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 28 Jan 2015 14:53:29 +0900
Subject: [PATCH 00/14 v2] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support V2
In-Reply-To: <20150127035835.GA1145@verge.net.au>
References: <20150126061747.6848.9708.sendpatchset@little-apple>
 <20150127011707.GD29710@verge.net.au>
 <20150127035835.GA1145@verge.net.au>
Message-ID: <CANqRtoRzvWMo9y_y80uz=kx=M5p-FzkgWPyZZ914sKHvQcM4Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Jan 27, 2015 at 12:58 PM, Simon Horman <horms@verge.net.au> wrote:
> On ?,  1? 27, 2015 at 10:17:09?? +0900, Simon Horman wrote:
>> On Mon, Jan 26, 2015 at 03:17:47PM +0900, Magnus Damm wrote:
>> > ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support V2
>> >
>> > [PATCH 01/14 v2] ARM: shmobile: mackerel: Remove ZBOOT code
>> > [PATCH 02/14 v2] ARM: shmobile: mackerel: Remove Legacy C board code
>> > [PATCH 03/14 v2] ARM: shmobile: mackerel dts: Remove Legacy DTS file
>> > [PATCH 04/14 v2] ARM: shmobile: mackerel: Remove DT binding documentation
>> > [PATCH 05/14 v2] ARM: shmobile: mackerel: Remove mach-type entry
>> > [PATCH 06/14 v2] ARM: shmobile: mackerel: Remove defconfig
>> > [PATCH 07/14 v2] ARM: shmobile: mackerel: Remove from MAINTAINERS
>> > [PATCH 08/14 v2] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
>> > [PATCH 09/14 v2] ARM: shmobile: sh7372: Remove Legacy C SoC code
>> > [PATCH 10/14 v2] ARM: shmobile: sh7372: Remove DT binding documentation
>> > [PATCH 11/14 v2] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
>> > [PATCH 12/14 v2] Documentation: Remove ZBOOT MMC/SDHI utility and docs
>> > [PATCH 13/14 v2] pinctrl: sh-pfc: sh7372: Remove PFC support
>> > [PATCH 14/14 v2] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
>> >
>> > Here is my latest attempt (V2) of legacy board and SoC support removal
>> > for Mackerel and sh7372. Both the ARM mach-shmobile code base and the
>> > PINCTRL subsystem is affected.
>> >
>> > Also get rid of the remaining ZBOOT MMC/SDHI code, documentation and
>> > utility that has no user once sh7372 is gone.
>> >
>> > The Cortex-A8 based sh7372 SoC is rather old and never went into mass
>> > production anyway, so these patches that remove SoC and board support
>> > will only affect a few selected developers.
>> >
>> > I wish we had some way to make use of the ZBOOT MMC/SDHI code, but
>> > without any board or SoC code it makes little sense to keep it.
>> >
>> > Thanks to Laurent and Geert for review!
>>
>> Sad to see all our hard work being deleted. But at the same
>> time its nice to be able to reduce our footprint by 8681 lines!
>>
>> I have queued up the first 12 patches of this series, that is the
>> non-pfc patches. They are queued up in a new sh7372-soc-removal-for-v3.21
>> branch which I intend to push as part of renesas-devel-20150127-v3.19-rc6 a
>> little later today.
>
> BTW, could you check that I queued up things correctly?

It looks fine to me. Thanks for your help!

/ magnus
