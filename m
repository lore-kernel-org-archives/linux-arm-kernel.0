From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 28 Jul 2017 07:39:30 -0700
Subject: [PATCH 0/2] arm64: dts: cleanup Broadcom boards per SoC
In-Reply-To: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
References: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <4d8c36d0-7422-120b-146b-33e74a7a518e@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Could you please pick up PATCH 1/2 of this series below and drop PATCH 2/2 ?


On 17-07-19 10:05 AM, Scott Branden wrote:
> Separate Broadcom boards per SoC to assist in cleaner management of boards.
> This has already been done for Stingray and is done here for RPI and NS2.
>
> If this is problematic for RPI please let me know and RPI patch can be
> dropped from patch series.
>
> Scott Branden (2):
>    arm64: dts: move ns2 into northstar2 directory
>    arm64: dts: move rpi into rpi directory
>
>   arch/arm64/boot/dts/broadcom/Makefile                        | 7 +++----
>   arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi                | 1 -
>   arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi       | 1 -
>   arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi       | 1 -
>   arch/arm64/boot/dts/broadcom/bcm283x.dtsi                    | 1 -
>   arch/arm64/boot/dts/broadcom/northstar2/Makefile             | 6 ++++++
>   arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-clock.dtsi | 0
>   arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-svk.dts    | 0
>   arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts    | 0
>   arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2.dtsi       | 0
>   arch/arm64/boot/dts/broadcom/rpi/Makefile                    | 5 +++++
>   arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi            | 1 +
>   arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837-rpi-3-b.dts   | 0
>   arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837.dtsi          | 0
>   arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi   | 1 +
>   arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi   | 1 +
>   arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi                | 1 +
>   17 files changed, 18 insertions(+), 8 deletions(-)
>   delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
>   delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
>   delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
>   delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi
>   create mode 100644 arch/arm64/boot/dts/broadcom/northstar2/Makefile
>   rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-clock.dtsi (100%)
>   rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-svk.dts (100%)
>   rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts (100%)
>   rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2.dtsi (100%)
>   create mode 100644 arch/arm64/boot/dts/broadcom/rpi/Makefile
>   create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm2835-rpi.dtsi
>   rename arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837-rpi-3-b.dts (100%)
>   rename arch/arm64/boot/dts/broadcom/{ => rpi}/bcm2837.dtsi (100%)
>   create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-smsc9514.dtsi
>   create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm283x-rpi-usb-host.dtsi
>   create mode 120000 arch/arm64/boot/dts/broadcom/rpi/bcm283x.dtsi
>
Thanks,
  Scott
