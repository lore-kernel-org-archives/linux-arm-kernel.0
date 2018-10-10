From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Oct 2018 06:19:30 -0500
Subject: [Question] directory for SoC-related DT binding
In-Reply-To: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
References: <CAK7LNATaD=G8BW316fkBWM2A+YXgP5tabaySR2Fs49Za_0p=3Q@mail.gmail.com>
Message-ID: <CABGGisx-iLr+CQ=JjmHEe5J_Qqpf0yrgOmSOHa74GnfwE_RKsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 6:08 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi,
>
>
> I see a bunch of vendor (or SoC) names in
> Documentation/device/bindings/arm/
>
> ./Documentation/devicetree/bindings/arm/altera
> ./Documentation/devicetree/bindings/arm/amlogic

Yeah, it's kind of a mixture of board/soc bindings mostly with some
ARM architecture, ARM, Ltd. IP, and SoC system reg bindings.

Eventually, I'd like to not split board bindings by arch and maybe we
should move all the system/misc reg bindings out.

[,,,]

> I also see some vendor names in
> Documentation/device/bindings/soc/
>
> ./Documentation/devicetree/bindings/soc/bcm
> ./Documentation/devicetree/bindings/soc/dove
> ./Documentation/devicetree/bindings/soc/fsl
> ./Documentation/devicetree/bindings/soc/mediatek
> ./Documentation/devicetree/bindings/soc/qcom
> ./Documentation/devicetree/bindings/soc/rockchip
> ./Documentation/devicetree/bindings/soc/ti
> ./Documentation/devicetree/bindings/soc/xilinx
> ./Documentation/devicetree/bindings/soc/zte

This I believe is mostly SoC system reg bindings though there's
probably a few other things.

> Confusingly, I see bcm, mediatek, rockchip
> in both locations.
>
> Is there any rule to choose one than the other?

Top-level SoC/board bindings in arm/ and anything else elsewhere ideally.

Rob
