From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 19 Apr 2016 16:38:14 -0500
Subject: [PATCH v2 2/2] Documentation: devicetree: Add PL310 PM bindings
In-Reply-To: <1461015411-14000-3-git-send-email-brad.mouring@ni.com>
References: <1456265019-23900-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
 <1461015411-14000-3-git-send-email-brad.mouring@ni.com>
Message-ID: <CAL_JsqL-LCt06ZYQL4FEu7vEdHaFCvBe5xnHbkZTf55yAf5Svw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 4:36 PM, Brad Mouring <brad.mouring@ni.com> wrote:
> Document the DT bindings for controlling ARM PL310 Power Control
> settings.
>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>

What happened to Josh's ack?

> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> index fe0398c..c1c756e 100644
> --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> @@ -84,6 +84,10 @@ Optional properties:
>  - prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
>    <1> (forcibly enable), property absent (retain settings set by
>    firmware)
> +- arm,dynamic-clock-gating : L2 dynamic clock gating. Value: <0> (forcibly
> +  disable), <1> or property absent (forcibly enable)
> +- arm,standby-mode: L2 standby mode enable. Value <0> (forcibly disable),
> +  <1>  or property absent (forcibly enable)

What happened to "retain settings set by firmware"?

Rob
