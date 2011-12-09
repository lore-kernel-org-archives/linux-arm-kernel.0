From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Dec 2011 14:17:21 +0800
Subject: [PATCH 2/2] regulator: add device tree support for max8997
In-Reply-To: <1323361659-11835-3-git-send-email-thomas.abraham@linaro.org>
References: <1323361659-11835-1-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111209061720.GF26952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 09:57:39PM +0530, Thomas Abraham wrote:

> +Required properties, if interrupts are delivered to host system:

These are just optional properties, really.

> +- interrupt-parent: Specifies the phandle of the interrupt controller to which
> +  the interrupts from max8997 are delivered to.
> +- interrupts: Interrupt specifiers for two interrupt sources.
> +  - First interrupt specifier is for 'irq1' interrupt.
> +  - Second interrupt specifier is for 'alert' interrupt.

What if the two are connected to different interrupt controllers?

> +    For LDO's:

Extra '.
