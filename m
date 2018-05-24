From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 10:05:16 +0200
Subject: [PATCH v5 3/4] ARM: dts: qcom: add gpio-ranges property
In-Reply-To: <0ae3376606a89bcdf3fe753a5c967f7103699e09.1526935804.git.chunkeey@gmail.com>
References: <270904bcbf03a6b6ac3150f4a7daa15aa7e97586.1526935804.git.chunkeey@gmail.com>
 <910e5a85a6a8020069996e2ff397c93e9c5fe18c.1526935804.git.chunkeey@gmail.com>
 <0ae3376606a89bcdf3fe753a5c967f7103699e09.1526935804.git.chunkeey@gmail.com>
Message-ID: <CACRpkdZ2QAuQDjkqERESmf7Lbr69XSaHj2JCO9hf8a6YiNP2RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 10:57 PM, Christian Lamparter
<chunkeey@gmail.com> wrote:

> This patch adds the gpio-ranges property to almost all of
> the Qualcomm ARM platforms that utilize the pinctrl-msm
> framework.
>
> The gpio-ranges property is part of the gpiolib subsystem.
> As a result, the binding text is available in section
> "2.1 gpio- and pin-controller interaction" of
> Documentation/devicetree/bindings/gpio/gpio.txt
>
> For more information please see the patch titled:
> "pinctrl: msm: fix gpio-hog related boot issues" from
> this series.
>
> Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> Tested-by: Sven Eckelmann <sven.eckelmann@openmesh.com> [ipq4019]
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess Andy will apply this?

Yours,
Linus Walleij
