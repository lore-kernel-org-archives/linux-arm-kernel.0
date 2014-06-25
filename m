From: dianders@chromium.org (Doug Anderson)
Date: Wed, 25 Jun 2014 12:54:31 -0700
Subject: [PATCH v4 04/14] clk: max77686: Improve Maxim 77686 PMIC clocks
 binding
In-Reply-To: <1403723019-6212-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1403723019-6212-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403723019-6212-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=Udt1G4MwSOAS-KmJa=zm4OBkPPxFO81ezY+ywG6zKRgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Jun 25, 2014 at 12:03 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Like most clock drivers, the Maxim 77686 PMIC clock binding
> follows the convention that the "#clock-cells" property is
> used to specify the number of cells in a clock provider.
>
> But the binding document is not clear enough that it shall
> be set to 1 since the PMIC support multiple clocks outputs.
>
> Also, explain that the clocks identifiers are defined in a
> header file that can be included by Device Tree source with
> client nodes to avoid using magic numbers.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>
> Changes since v3:
>  - Don't change clock-names property to make clear that it's
>    the consumer clock name and should not match the producer clock.
>    Suggested by Doug Anderson.
>
>  Documentation/devicetree/bindings/clock/maxim,max77686.txt | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
