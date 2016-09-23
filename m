From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 12:55:43 -0500
Subject: [PATCH v8 2/2] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1474300103-26659-3-git-send-email-ayaka@soulik.info>
References: <1474300103-26659-1-git-send-email-ayaka@soulik.info>
 <1474300103-26659-3-git-send-email-ayaka@soulik.info>
Message-ID: <20160923175543.GA4471@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 11:48:23PM +0800, Randy Li wrote:
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
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/arm/samsung/samsung-boards.txt        |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/exynos4412-itop-elite.dts        | 240 +++++++++++++++++++++
>  3 files changed, 244 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts

Acked-by: Rob Herring <robh@kernel.org>
