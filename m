From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 26 Aug 2015 10:59:22 -0500
Subject: [PATCH 1/4] remoteproc: dt: Provide bindings for ST's Remote
 Processor Controller driver
In-Reply-To: <1440594483-29601-2-git-send-email-lee.jones@linaro.org>
References: <1440594483-29601-1-git-send-email-lee.jones@linaro.org>
 <1440594483-29601-2-git-send-email-lee.jones@linaro.org>
Message-ID: <55DDE25A.2050000@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2015 08:08 AM, Lee Jones wrote:
> diff --git a/Documentation/devicetree/bindings/remoteproc/st-rproc.txt b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> new file mode 100644
> index 0000000..6a933c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> @@ -0,0 +1,38 @@
> +STMicroelectronics Remote Processor
> +-----------------------------------
> +
> +This binding provides support for adjunct processors found on ST SoCs.
> +
> +The remote processors can be controlled from the bootloader or the primary OS.
> +If the bootloader starts a remote processor processor the primary OS must detect
> +its state and act accordingly.
> +
> +The node name is significant, as it defines the name of the CPU and the name
> +of the firmware to load: "rproc-<name>-fw".

This business about the firmware name describes a behavior of Linux's
core remoteproc code and seems out of place in a binding document.
