From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 27 Sep 2018 09:15:11 +0530
Subject: [PATCHv4 4/6] ARM: dts: exynos: Add CD and WP pins to Odroid
 XU3/XU4 SD card
In-Reply-To: <20180926190639.GA6461@kozik-lap>
References: <20180922075238.884-1-linux.amoon@gmail.com>
 <20180922075238.884-6-linux.amoon@gmail.com>
 <20180926190639.GA6461@kozik-lap>
Message-ID: <CANAwSgSPkKL3jaHHSkEhgocKT_Sq4zg3Z=+7d5889ttpnNPHDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,
On Thu, 27 Sep 2018 at 00:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Sep 22, 2018 at 07:52:36AM +0000, Anand Moon wrote:
> > Add the card-detect and write-protect GPIO pins for OdroidXU3/XU4
> > SD card by adding pinctrl setting for wp-gpio pin and set it to
> > active low.
> >
> > This also removes debug messages:
> >     dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
> >     dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> >
> > Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Fix the commit message and squash it with cd-gpios and wp-gpio
> > patches into single patch as suggested by Krzysztof.
>
> As Marek pointed to my Odroid XU patch, there is no point of adding
> cd-gpios and wp-gpios properties.
>
> Adding pin configuration for wp pin is also not needed. Reset values are
> working properly. However there might be meaning of adding it just in
> case - if bootloader decided to touch it...
>
> Best regards,
> Krzysztof
>

Do I need to send the all the patches again or just resend this as per
your patch for Odroid XU.
with dropping the cd-gpios and wp-gpios changes.

Best Regards
-Anand
