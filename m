From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2018 16:10:44 +0200
Subject: [PATCH v2 1/1] dts: qcom: db820c: Add gpio-line-names property
In-Reply-To: <20180418134601.8502-2-manivannan.sadhasivam@linaro.org>
References: <20180418134601.8502-1-manivannan.sadhasivam@linaro.org>
 <20180418134601.8502-2-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdZ6oFdnnXWE6anKR9DQGVo5v_ecfveAVKYDhLr-067nHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 3:46 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add gpio-line-names property for Dragonboard820c based on APQ8096 SoC.
> There are 4 gpio-controllers present on this board, including the
> APQ8096 SoC, PM8994 (GPIO and MPP) and PMI8994 (GPIO).
>
> Lines names are derived from 96Boards CE Specification 1.0, Appendix
> "Expansion Connector Signal Description". Line names for PMI8994 MPP
> pins are not added due to the absence of the gpio-controller support.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
