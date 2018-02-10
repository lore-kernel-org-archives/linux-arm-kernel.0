From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Sat, 10 Feb 2018 08:07:58 +0100
Subject: [PATCH 5/6] ARM: dts: tegra: apalis-tk1: copyright period,
 spurious newlines
In-Reply-To: <20180210013806.28496-6-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
 <20180210013806.28496-6-marcel@ziswiler.com>
Message-ID: <CAOFm3uH+aasUA9MrV+uXvHUT=fzS63PvC2fDfNo3q687dUQ_dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcel,

On Sat, Feb 10, 2018 at 2:38 AM, Marcel Ziswiler <marcel@ziswiler.com> wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Update the copyright period and get rid of some spurious newlines.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> ---
>
>  arch/arm/boot/dts/tegra124-apalis-eval.dts |  6 ++----
>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 11 +----------
>  2 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> index f1010cefb993..a6ad759dddb4 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> +++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2016 Toradex AG
> + * Copyright 2016-2018 Toradex AG
>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual

Since you are fixing copyrights, would you consider also fixing the
license to use a proper SPDX Id instead?

It would be super gentle of you!

And you will get extra good karma point if you feel like doing the
same for every Toradex-copyrighted files ;)

The (still new and fresh) license documentation contributed by tglx
--the only real-time docu-mentalist-- is in:
Documentation/process/license-rules.rst

Thanks!
-- 
Cordially
Philippe Ombredanne
