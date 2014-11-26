From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 26 Nov 2014 19:10:28 +0100
Subject: [PATCHv0 0/2] arm: mvebu: fixes for previous DS213j/DS414 series
In-Reply-To: <20141126041251.GL22670@titan.lakedaemon.net> (Jason Cooper's
 message of "Tue, 25 Nov 2014 23:12:51 -0500")
References: <cover.1416670812.git.arno@natisbad.org>
 <20141126041251.GL22670@titan.lakedaemon.net>
Message-ID: <87vbm1bzor.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Cooper <jason@lakedaemon.net> writes:

>>   arm: mvebu: fix wrongly named DS414 pinctrl entries
>>   arm: mvebu: normalize pinctrl entries for Armada SoCs
>> 
>>  arch/arm/boot/dts/armada-xp-axpwifiap.dts       | 12 ++++++------
>>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |  4 ++--
>>  arch/arm/boot/dts/armada-xp-synology-ds414.dts  | 10 +++++-----
>>  arch/arm/boot/dts/armada-xp.dtsi                |  6 +++---
>>  4 files changed, 16 insertions(+), 16 deletions(-)
>
> Thanks for taking care of this.  Applied to mvebu/dt

I was the one screwing the series in the first place. So that was the
least I could do. Next time you see sth no kosher in one of my series,
do not hesitate to ask for a vN+1.

Cheers,

a+
