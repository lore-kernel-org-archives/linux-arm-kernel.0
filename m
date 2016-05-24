From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 24 May 2016 09:51:22 -0600
Subject: [PATCH 0011/1529] Fix typo
In-Reply-To: <20160521113648.31841-1-andrea.gelmini@gelma.net>
References: <20160521113648.31841-1-andrea.gelmini@gelma.net>
Message-ID: <CANLsYkxtvYmHRsisjO2DyW85yF3EQ+Jy6Gx4AZ+pkzt7cZM8-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2016 at 05:36, Andrea Gelmini <andrea.gelmini@gelma.net> wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 93147c0c..a846d4b 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -6,7 +6,7 @@ SoCs tracing needs. These trace components can generally be classified as
>  sinks, links and sources. Trace data produced by one or more sources flows
>  through the intermediate links connecting the source to the currently selected
>  sink. Each CoreSight component device should use these properties to describe
> -its hardware characteristcs.
> +its hardware characteristics.

Thank you for that.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>
>  * Required properties for all components *except* non-configurable replicators:
>
> --
> 2.8.2.534.g1f66975
>
