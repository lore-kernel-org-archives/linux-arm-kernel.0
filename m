From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 18 Apr 2016 07:45:00 +0300
Subject: [PATCH 0/3] arm: dts: lpc32xx: update ssp / spi nodes
In-Reply-To: <3938626.hTOUROu3U1@wuerfel>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
 <3938626.hTOUROu3U1@wuerfel>
Message-ID: <5714664C.7080201@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 16.04.2016 22:34, Arnd Bergmann wrote:
> On Thursday 14 April 2016 08:20:34 slemieux.tyco at gmail.com wrote:
>> From: Sylvain Lemieux <slemieux@tycoint.com>
>>
>> This patchset change the following:
>> 1) adds clock properties to spi peripheral devices,
>>    clock ids are taken from dt-bindings/clock/lpc32xx-clock.h
>>
>> 2) disable, by default, the SSP0/SPI1 and SSP1/SPI2 shared pinout;
>>    shared pin should be enable in board specific dts, as needed.
>>
>> 3) enable SSP0 used by PHY3250.
>>
>> Sylvain Lemieux (3):
>>   arm: dts: lpc32xx: add clock properties to spi nodes
>>   arm: dts: lpc32xx: disabled ssp0/spi1 & ssp1/spi2 by default
>>   arm: dts: phy3250: enable ssp0
>>
>>  arch/arm/boot/dts/lpc32xx.dtsi | 16 ++++++++++++++
>>  arch/arm/boot/dts/phy3250.dts  |  1 +
>>  2 files changed, 15 insertions(+)
>>
>>
> 
> The patches look fine, but it's unclear what you want to happen with them
> as long as the maintainer situation is not resolved. I've seen patches
> from Vladimir and you recently, and none from Roland, so I think it would
> be good if one or both of you could officially step up to be maintainers
> and collect all patches to forward them to arm at kernel.org for inclusion.

for v4.5 and v4.6 I collected my own patches from LAKML after review,
I started to do it for v4.7, but probably a bit later than desired.

Could you please remind me, when do ARM maintainers generally stop
applying "for-next" pull requests?

> Once we have an agreement on who does this, please send a patch to
> update the MAINTAINERS file.

I'll send a change on behalf of myself, at this point I don't think that
pure lpc32xx maintenance (deliberately here I exclude development!) task
takes more than 20 hours per month, which is affordable for me,
Sylvain please express your view.

> For the patch descriptions, please always start the subject with 'ARM',
> not 'arm' to follow the common convention, and always add a multi-line
> description even for trivial patches.
> 
> 	Arnd
> 

--
With best wishes,
Vladimir
