From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 Sep 2016 21:40:21 +0200
Subject: [PATCH 00/10] ARM: dts: berlin: fix dtc warnings
In-Reply-To: <20160906084013.2887-1-jszhang@marvell.com>
References: <20160906084013.2887-1-jszhang@marvell.com>
Message-ID: <57EC1CA5.2030102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.09.2016 10:40, Jisheng Zhang wrote:
> This is a clean up series to fix berlin arm platforms dtc warnings.
> Firstly we remove skeleton.dtsi inclusion. Then add missing unit name
> of /soc node and /memory node. Lastly, we fix regulators' name
>
> Jisheng Zhang (10):
>    ARM: dts: berlin2q: Remove skeleton.dtsi inclusion
>    ARM: dts: berlin2cd: Remove skeleton.dtsi inclusion
>    ARM: dts: berlin2: Remove skeleton.dtsi inclusion
>    ARM: dts: berlin2q: Add missing unit name to /soc node
>    ARM: dts: berlin2cd: Add missing unit name to /soc node
>    ARM: dts: berlin2: Add missing unit name to /soc node
>    ARM: dts: berlin2q-marvell-dmp: add missing unit name to /memory node
>    ARM: dts: chromecast: add missing unit name to /memory node

Jisheng,

Applied the 8 patches above.

>    ARM: dts: sony-nsz-gs7: add missing unit name to /memory node

I didn't receive this one and could not find it online.
I recreated the patch by using the chromecast patch above, so
applied.

>    ARM: dts: berlin2q-marvell-dmp: fix regulators' name

I have no clue what it should be fixed to.

Sebastian

>   arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        |  2 +-
>   arch/arm/boot/dts/berlin2.dtsi                    |  5 +++--
>   arch/arm/boot/dts/berlin2cd-google-chromecast.dts |  2 +-
>   arch/arm/boot/dts/berlin2cd.dtsi                  |  5 +++--
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 12 ++++++------
>   arch/arm/boot/dts/berlin2q.dtsi                   |  6 +++---
>   6 files changed, 17 insertions(+), 15 deletions(-)
>
