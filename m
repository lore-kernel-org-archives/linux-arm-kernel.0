From: a0393675@ti.com (Keerthy)
Date: Tue, 10 May 2016 09:54:02 +0530
Subject: [PATCH RESEND 0/4] arm: dts: am57xx: Correct the thermal
 thresholds
In-Reply-To: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
References: <1461837949-11116-1-git-send-email-j-keerthy@ti.com>
Message-ID: <57316262.80003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Thursday 28 April 2016 03:35 PM, Keerthy wrote:
> Noticed that earlier post had a wrong list name hence resending the
> series.
>
> Currently all the am57xx versions are wrongly re-using the dra7  thermal
> threholds. Introduing the correct thermal thresholds based on industrial
> or commercial grade silicon present on the individual boards.
>
> Tested on AM57XX-BEAGLE-X15 (Commercial) and AM572X-IDK(Industrial)
> for the trip_point node sysfs temperatures.
>

A Gentle ping on this series.

> These patches are on top of:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/tmlind/linux-omap/+/omap-for-v4.7/dt
>
> Keerthy (4):
>    ARM: dts: am57xx: Introduce commercial grade thermal thresholds
>    ARM: dts: am57xx: Introduce industrial grade thermal thresholds
>    ARM: dts: am57xx: Include the commercial grade thresholds
>    ARM: dts: am57xx-idk: Include Industrial grade      thermal thresholds
>
>   arch/arm/boot/dts/am57xx-beagle-x15.dts        |  1 +
>   arch/arm/boot/dts/am57xx-commercial-grade.dtsi | 23 +++++++++++++++++++++++
>   arch/arm/boot/dts/am57xx-idk-common.dtsi       |  2 ++
>   arch/arm/boot/dts/am57xx-industrial-grade.dtsi | 23 +++++++++++++++++++++++
>   4 files changed, 49 insertions(+)
>   create mode 100644 arch/arm/boot/dts/am57xx-commercial-grade.dtsi
>   create mode 100644 arch/arm/boot/dts/am57xx-industrial-grade.dtsi
>
