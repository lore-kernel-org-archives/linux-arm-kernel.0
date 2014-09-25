From: drake@endlessm.com (Daniel Drake)
Date: Thu, 25 Sep 2014 14:47:08 -0600
Subject: [PATCH] ARM: dts: Specify default clocks for Exynos4 FIMC devices
In-Reply-To: <CAD8Lp46tzgtEaUMS2+QSKoObW+kedWvAqJXMU5uKqnHp_LumGw@mail.gmail.com>
References: <1410367054-30926-1-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp45F_rgN0JZ2n77VXSqN4C6K_hkqu6vsPqha-UbsVf4bow@mail.gmail.com>
 <5424597A.7040904@samsung.com>
 <CAD8Lp46tzgtEaUMS2+QSKoObW+kedWvAqJXMU5uKqnHp_LumGw@mail.gmail.com>
Message-ID: <CAD8Lp44UENSjFVuejnm8bKpyLsu0X0SErBgfmVtVPH6Tv9SptA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 1:44 PM, Daniel Drake <drake@endlessm.com> wrote:
>> AFAIK 880 MHz is recommended MPLL frequency for Exynos4412 EVT2.0, which
>> is revision of the Exynos4412 SoC the Odroid U3 boards are populated with.
>> You can read the main/sub revision information from the chip ID register
>> (at 0x10000000).
>
> Thanks for the information. Might be worth a quick comment in
> exynos4x12.dtsi then, saying that the defaults here are for Exynos4412
> EVT2.0 and might want to be overridden for other versions of the SoC.

Also can you double check this?
The old ODROID-X is Exynos4412 EVT1.0 and runs 880MHz MPLL.

Daniel
