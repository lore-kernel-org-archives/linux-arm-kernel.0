From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 09 Mar 2015 13:46:25 -0700
Subject: [PATCH 1/4] dt-bindings: soc: Add documentation for the MediaTek
 SCPSYS unit
In-Reply-To: <1425888603-25800-2-git-send-email-s.hauer@pengutronix.de>
 (Sascha Hauer's message of "Mon, 9 Mar 2015 09:10:00 +0100")
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7hegox6gri.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> This adds documentation for the MediaTek SCPSYS unit found in MT8173 SoCs.

Curious if this IP unique to the 8173?  or maybe also used on 8135? ...

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> new file mode 100644
> index 0000000..4764a03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -0,0 +1,32 @@
> +MediaTek SCPSYS
> +===============
> +
> +The System Control Processor System (SCPSYS) has several power management
> +related tasks in the system. The tasks include thermal measurement, dynamic
> +voltage frequency scaling (DVFS), interrupt filter and lowlevel sleep control.
> +The System Power Manager (SPM) inside the SCPSYS is for the MTCMOS power
> +domain control.
> +
> +The driver implements the Generic PM domain bindings described in
> +power/power_domain.txt. It provides the power domains defined in
> +include/dt-bindings/power/mt8173-power.h.
> +
> +Required properties:
> +- compatible: Must be "mediatek,mt8173-scpsys"

... if so, maybe the compatible could/should be slightly more generic?

Kevin
