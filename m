From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 18 Apr 2014 10:12:52 -0700
Subject: [PATCH] ARM: mach-bcm: add ARM_ERRATA_775420
In-Reply-To: <1397778296-27537-1-git-send-email-sbranden@broadcom.com>
References: <1397778296-27537-1-git-send-email-sbranden@broadcom.com>
Message-ID: <53515D14.5090704@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-04-17 04:44 PM, Scott Branden wrote:
> ARM_ERRATA_775420 needs to be enabled.
>
> A data cache maintenance operation which aborts, followed by an ISB,
> without any DSB in-between, might lead to deadlock.
>
> Affects: bug present in Cortex-A9 r3p0 and earlier. Fixed in r4p0.
>
> Cortex-A9 r3p0 is used in a multitude of Broadcom parts including
> the bcm21664, bcm281xx, 5301x families of devices.
>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>
> Tested-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Alex Edler <edler@linaro.org>
New patch V2 being sent out to correct Alex' last name.
