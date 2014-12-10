From: varkabhadram@gmail.com (Varka Bhadram)
Date: Wed, 10 Dec 2014 06:57:08 +0530
Subject: [PATCH 1/4] i2c: iProc: define Broadcom iProc I2C binding
In-Reply-To: <1418172891-19441-2-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418172891-19441-1-git-send-email-rjui@broadcom.com>
 <1418172891-19441-2-git-send-email-rjui@broadcom.com>
Message-ID: <5487A16C.5000707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 10 December 2014 06:24 AM, Ray Jui wrote:
> Document the I2C device tree binding for Broadcom iProc family of
> SoCs
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |   37 ++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> new file mode 100644
> index 0000000..81f982c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -0,0 +1,37 @@
> +Broadcom iProc I2C controller
> +
> +Required properties:
> +
> +- compatible:
> +    Must be "brcm,iproc-i2c"
> +
> +- reg:
> +    Define the base and range of the I/O address space that contain the iProc
> +    I2C controller registers
> +
> +- interrupts:
> +    Should contain the I2C interrupt
> +
> +- clock-frequency:
> +    This is the I2C bus clock. Need to be either 100000 or 400000
> +
> +- #address-cells:
> +    Always 1 (for I2C addresses)
> +
> +- #size-cells:
> +    Always 0
> +

All the properties defined with two lines of statements.

Why cant they be with single line statement, like:

compatible:	Must be "brcm,iproc-i2c"
reg:		Define the base and range of the I/O address space that
		contain the iProc I2C controller registers

....


-- 
Thanks and Regards,
Varka Bhadram.
