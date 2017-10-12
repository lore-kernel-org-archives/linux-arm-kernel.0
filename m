From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 12 Oct 2017 22:50:01 +0200
Subject: [PATCH 0/2] Enable the Amlogic Meson SDIO MMC controller
In-Reply-To: <7ho9pdfc8p.fsf@baylibre.com>
References: <20171007162940.14595-1-martin.blumenstingl@googlemail.com>
 <7ho9pdfc8p.fsf@baylibre.com>
Message-ID: <CAFBinCAPsrw89nhWevO6=BG=POa5caepgCNg0xHx=iWD7H6jWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Oct 12, 2017 at 2:20 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> Now that the SDIO MMC driver is queued for v4.15 we need to prepare
>> our platform so boards can actually use this driver.
>> This adds the Meson SDIO MMC controller to the .dts files and
>> enables the corresponding driver in the multi_v7_defconfig.
>
> Just curious... were you able to test this on any meson8 platform?
I have two 32-bit Meson boards:
- Meson8m2 (S812) based Akaso M8S
- Meson8b based Endless Mini EC-100

I do not have any Meson8 (S805) based board, however I believe that
there aren't many differences between Meson8 and Meson8m2 in terms of
"peripherals" (they share the same mach-meson8 directory in Amlogic's
kernel sources).

most of my tests were done my Meson8m2 board, however I also did a
quick test on the EC-100 some time ago.

> [...]
>
>> Martin Blumenstingl (2):
>>   ARM: dts: meson: add the SDIO MMC controller
>
> Applied to v4.15/dt
>
>>   ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC controller
>
> Applied to v4.15/defconfig
Thank you!

> Thanks!
>
> Kevin


Martin
