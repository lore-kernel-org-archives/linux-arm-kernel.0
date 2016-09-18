From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Sep 2016 21:23:14 +0200
Subject: [PATCH v7 2/3] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1474207279-9662-3-git-send-email-ayaka@soulik.info>
References: <1474207279-9662-1-git-send-email-ayaka@soulik.info>
 <1474207279-9662-3-git-send-email-ayaka@soulik.info>
Message-ID: <20160918192314.GA6676@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 10:01:18PM +0800, Randy Li wrote:
> The TOPEET itop exynos 4412 have three versions base board. The
> Elite version is the cheap one without too much peripheral devices
> on it.
> 
> Currently supported are serial console, wired networking(USB),
> USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
> PWM beeper, ADC and LEDs. The WM8960 analog audio codec is also
> enabled.
> 
> The FIMC is not used for camera currently, I enabled it just for a
> colorspace convertor.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos4412-itop-elite.dts        | 240 +++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts

Looks good to me, for the record:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

You don't need to resend the third patch. Rob took it.

Best regards,
Krzysztof
