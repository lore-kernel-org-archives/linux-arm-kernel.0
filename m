From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 26 May 2015 11:25:46 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <20150523082820.GK8557@lukather>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
 <13641152.Yt4ZI3oT6L@wuerfel>
 <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
 <20150521185122.GD8557@lukather>
 <CALszF6BuvTf86k6S5UEYZs-DJSTehy=+Csb3c6jxMU90MN05zw@mail.gmail.com>
 <20150523082820.GK8557@lukather>
Message-ID: <CALszF6Dvbu8sKGvtOYKMPKWo+Z6+8927mfmLR=CDBJPPR300wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

2015-05-23 10:28 GMT+02:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> On Thu, May 21, 2015 at 10:10:35PM +0200, Maxime Coquelin wrote:
>> We have the same problem on stm32, as just discussed with Andreas [0].
>> I decided to patch the bootloader to deassert timers reset, after
>> discussions with Rob Herring and Arnd.
>
> That seems like the best solution, but we don't have control over the
> bootloader in most cases. We have an alternative implementation (ie
> mainline u-boot) that is required for a few things already, but I'd
> really like to still be able to at least boot the kernel on a "legacy"
> bootloader (that is the one flashed on the device).

For sure it will have to remain compliant with the legacy bootloader.
It is easier for STM32 since it is a newly platform.

Regards,
Maxime C.
