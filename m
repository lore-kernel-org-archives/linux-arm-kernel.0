From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 13 Jan 2015 14:36:18 -0700
Subject: [PATCH] coresight: remove the unnecessary replicator property
In-Reply-To: <1421054994-64261-1-git-send-email-xiakaixu@huawei.com>
References: <1421054994-64261-1-git-send-email-xiakaixu@huawei.com>
Message-ID: <CANLsYky53cirZ9K9Jrvpqh617F2AAZSWudnaB1X641w=G_p46Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 January 2015 at 02:29, Kaixu Xia <xiakaixu@huawei.com> wrote:
> Now we use the device name to identify replicator instead
> of a unique number, so just remove it.
>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index d790f49..a308935 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -38,8 +38,6 @@ its hardware characteristcs.
>           AMBA markee):
>                 - "arm,coresight-replicator"
>
> -       * id: a unique number that will identify this replicator.
> -
>         * port or ports: same as above.
>
>  * Optional properties for ETM/PTMs:
> @@ -94,8 +92,6 @@ Example:
>                  * AMBA bus.  As such no need to add "arm,primecell".
>                  */
>                 compatible = "arm,coresight-replicator";
> -               /* this will show up in debugfs as "0.replicator" */
> -               id = <0>;
>
>                 ports {
>                         #address-cells = <1>;
> --
> 1.8.5.5
>

Applied - thanks.
