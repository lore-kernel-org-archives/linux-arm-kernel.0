From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Fri, 16 Jan 2015 22:05:08 +0900
Subject: [PATCH 3/3] ARM: dts: rockchip: add dts for ChipSPARK Rayeager
 PX2 board
In-Reply-To: <2706590.Kkspa3JYVn@phil>
References: <1421289659-16627-1-git-send-email-naobsd@gmail.com>
 <1421289659-16627-4-git-send-email-naobsd@gmail.com>
 <2706590.Kkspa3JYVn@phil>
Message-ID: <CAFnsNoTitoUk2n2WWqzo_=7_VN4YXdKuGC-_fF3c4tNbasQjEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thank you for your review!

On Fri, Jan 16, 2015 at 1:19 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> +     vcc_sata: sata-regulator {
>> +             compatible = "regulator-fixed";
>> +             enable-active-high;
>> +             gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sata_pwr>;
>> +             regulator-name = "usb_5v";
>
> why is it named "usb_5v"?

it's came from schematic.

I think it follows same rule as "vcc_host { regulator-name =
"host-pwr"; }" in rk3188-radxarock.dts.

I'll include rest of your comments in v2.

Regards,
