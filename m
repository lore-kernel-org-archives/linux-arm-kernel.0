From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 29 Jul 2014 12:30:47 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140729103047.GC18250@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 09:00:25PM +0800, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Add documentation for the guidelines of how to use ACPI
> on ARM64.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/arm64/arm-acpi.txt |  240 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
>  create mode 100644 Documentation/arm64/arm-acpi.txt
> 
> diff --git a/Documentation/arm64/arm-acpi.txt b/Documentation/arm64/arm-acpi.txt
> new file mode 100644
> index 0000000..12cd550
> --- /dev/null
> +++ b/Documentation/arm64/arm-acpi.txt
> @@ -0,0 +1,240 @@
> +ACPI on ARMv8 Servers
> +---------------------

[...]

> +
> +
> +There exists in the ACPI 5.1 specification no standard binding for these objects
> +to enable programmable levels or rates so this should be avoid if possible and
> +the resources set to appropriate level by the firmware. If this is not possible
> +then any manipulation should be abstracted in ASL.
> +

I'm not a native English speaker, but this wording sounds strange to me.
I would suggest "There exists no specification in the the..." or more
simply "The ACPI 5.1 specification does not contain any standard...".

-Christoffer
