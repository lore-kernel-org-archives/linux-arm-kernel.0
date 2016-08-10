From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 15:31:03 -0500
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <1470691445-27571-2-git-send-email-linus.walleij@linaro.org>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <1470691445-27571-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160810203103.GA4581@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 11:24:02PM +0200, Linus Walleij wrote:
> This adds device tree bindings for the External Bus Interface 2, EBI2
> to the Qualcomm SoC drivers.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,ebi2.txt     | 134 +++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ebi2.txt

Please address my previous comments:

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/443826.html
