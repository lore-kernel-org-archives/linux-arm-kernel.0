From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 7 May 2015 18:10:07 -0700
Subject: [PATCH 0/2] ARM: sun9i: cubieboard4: Enable USB hosts and LEDs
In-Reply-To: <1431017037-28331-1-git-send-email-wens@csie.org>
References: <1431017037-28331-1-git-send-email-wens@csie.org>
Message-ID: <CANMBJr6-YPLHe6kWnEeAnXA1K5kUKrK+wE8aDH+XqUVaak+v3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ChenYu,

On 7 May 2015 at 09:43, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi Maxime,
>
> This small series enables USB host and LED support on the Cubieboard4.
> We already support these on the Optimus, so it's just dts stuff.
>
>
> Regards
> ChenYu
>
>
> Chen-Yu Tsai (2):
>   ARM: dts: sun9i: cubieboard4: Enable USB support
>   ARM: dts: sun9i: cubieboard4: Enable LEDs

Thanks for posting these patches. I gave this series a spin on my
cubieboard4 atop next-20150507 both with sunxi_defconfig and
multi_v7_defconfig.  Tested all four USB ports with various USB
devices, and for good measure toggled the LED's :) Everything worked
as expected, so feel free to add my

Tested-by: Tyler Baker <tyler.baker@linaro.org>

>
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 83 +++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> --
> 2.1.4
>

Cheers,

Tyler
