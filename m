From: mporter@linaro.org (Matt Porter)
Date: Fri, 14 Mar 2014 12:54:10 -0400
Subject: [PATCH v5 5/5] ARM: dts: add bcm590xx pmu support and enable for
 bcm28155-ap
In-Reply-To: <1394633237-16837-6-git-send-email-mporter@linaro.org>
References: <1394633237-16837-1-git-send-email-mporter@linaro.org>
 <1394633237-16837-6-git-send-email-mporter@linaro.org>
Message-ID: <20140314165410.GC25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 10:07:17AM -0400, Matt Porter wrote:
> Add a dtsi to support the BCM590xx PMUs used by the BCM281xx family
> of SoCs. Enable regulators for use with the dwc2 and sdhci on
> bcm28155-ap.
> 
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Signed-off-by: Matt Porter <mporter@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>

Applied to mach-bcm armsoc/for-3.15/dt

-Matt
