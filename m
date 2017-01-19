From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 13:16:50 -0600
Subject: [PATCH 1/3 v3] iio: adc: add device tree bindings for Qualcomm
 PM8xxx ADCs
In-Reply-To: <20170117142515.10578-1-linus.walleij@linaro.org>
References: <20170117142515.10578-1-linus.walleij@linaro.org>
Message-ID: <20170119191650.o3ghoysxkhrqw4gw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:25:13PM +0100, Linus Walleij wrote:
> This adds the device tree bindings for the Qualcomm PM8xxx
> ADCs. This is based on the existing DT bindings for the
> SPMI ADC so there are hopefully no controversial features.
> 
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-arm-msm at vger.kernel.org
> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Collapse the ratiometric property into one that enables and
>   selects a ratiometric reference in one go.
> - Use foo: adc-channel at X notation consequently
> - Document that the reference voltage is compulsory.
> ChangeLog v1->v2:
> - Spelling fixes
> ---
>  .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 149 +++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt

Acked-by: Rob Herring <robh@kernel.org>
