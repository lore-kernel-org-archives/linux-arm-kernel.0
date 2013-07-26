From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Jul 2013 12:39:34 +0100
Subject: XCLKOUT in exynos5250 clock driver
In-Reply-To: <51F247B6.9010902@linaro.org>
References: <20130725145158.GI9858@sirena.org.uk> <51F247B6.9010902@linaro.org>
Message-ID: <20130726113934.GD9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 03:26:06PM +0530, Tushar Behera wrote:

> Information as per Exynos5250 user manual:
> "XCLKOUT is an output pin for debugging clocks. Exynos5250 has a CLKOUT
> logic which can select one of the clocks (within its clock domains) and
> output that through XCLKOUT pin."

Yeah, I know what XCLKOUT is but to implement this in the driver and DT
I'd need to know about the register or registers that are used to
configure the mux.

> Not sure if XCLKOUT on Arndale schematics means the same.

I'd be astonished if it meant anything else, it's fairly clearly
labelled as that on the schematics and this is a *very* common pattern
in system designs using Samsung SoCs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/4242f00d/attachment.sig>
