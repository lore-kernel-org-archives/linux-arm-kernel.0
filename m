From: dianders@chromium.org (Doug Anderson)
Date: Wed, 8 Aug 2018 13:28:52 -0700
Subject: [PATCH 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
In-Reply-To: <20180808191339.16875-2-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
 <20180808191339.16875-2-mka@chromium.org>
Message-ID: <CAD=FV=UcD0cb+jwNcw_GO_Jy_B7gMthXtuZrYaWN7bOW8OsXhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
> 'reg' property consists of two values, the SPMI address and the length
> of the controller's registers. However the SPMI bus to which it is added
> specifies "#size-cells = <0>;". Remove the controller register length
> from the documentation of the field and the example.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
