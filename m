From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 6 Mar 2017 09:24:48 +0200
Subject: [PATCH] ARM: dts: exynos: Add power button for Odroid XU3/4
In-Reply-To: <1488768729-9435-1-git-send-email-brian.kim@hardkernel.com>
References: <1488768729-9435-1-git-send-email-brian.kim@hardkernel.com>
Message-ID: <CAJKOXPcwzy_hAMLoUNcJxYHjHfUF+YmeqSLPy2spvyCwck=TaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 4:52 AM, Brian Kim <brian.kim@hardkernel.com> wrote:
> The power button on Odroid XU3/4 is connected with the PWRON pin of
> s2mps11 PMIC. The s2mps11 sends low signal to GPIO input in exynos 5422
> via ONOB pin.
>
> This patch adds devicetree bindings for the power button of Odroid
> XU3/4.
>
> Signed-off-by: Brian Kim <brian.kim@hardkernel.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>

Hi,

Thanks for the patch.

You sent almost the same patch as Anand did some time ago (with few
missing things) :
https://patchwork.kernel.org/patch/8388491/

All previous comments apply, including that you added a key for gpx0-3
which is not a PWRON and it does not match description at all.

Best regards,
Krzysztof
