From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 17 Dec 2015 22:08:33 +0100
Subject: [PATCH v3 0/4] Raspberry Pi power domains
In-Reply-To: <2899341.Os5E8ounKE@wuerfel>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
 <CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com>
 <878u4sx5gs.fsf@eliezer.anholt.net> <2899341.Os5E8ounKE@wuerfel>
Message-ID: <CAPDyKFokMdtcwG=0cDP3zKnnLrAxKDGWffWouvyVK0r53nxktg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 December 2015 at 21:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 December 2015 11:03:47 Eric Anholt wrote:
>> >>
>> >>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>> >>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>> >>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>> >>  arch/arm/mach-bcm/Kconfig                          |  10 +
>> >>  arch/arm/mach-bcm/Makefile                         |   1 +
>> >>  arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
>> >>  include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
>> >>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>> >>  8 files changed, 360 insertions(+), 1 deletion(-)
>> >>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
>> >>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>> >>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
>> >>
>> >> --
>> >> 2.6.2
>> >>
>> >
>> > Besides a nitpick for patch2, I would also reverse the order of patch3
>> > and patch2. DT docs should go in before the actual parsing of the new
>> > bindings/compatibles.
>> >
>> > Anyway, for the hole series, you may add my:
>> >
>> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Would your tree be pulling the series (since it's power domains), or
>> should I (since it's SOC stuff)?
>>
>
> All of the above files go through the arm-soc tree by default.

That should work as I don't see any other dependency, unless
Eric/Alexander think there is.

Kind regards
Uffe
