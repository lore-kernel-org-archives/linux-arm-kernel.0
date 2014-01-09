From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Jan 2014 18:14:05 +0000
Subject: [PATCH 6/7] devicetree: bindings: Document Krait performance
 monitor units (PMU)
In-Reply-To: <1389221984-10973-7-git-send-email-sboyd@codeaurora.org>
References: <1389221984-10973-1-git-send-email-sboyd@codeaurora.org>
 <1389221984-10973-7-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140109181404.GJ17838@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 10:59:43PM +0000, Stephen Boyd wrote:
> Document the Krait PMU compatible string.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 3e1e498fea96..ce7cccb99d87 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -16,6 +16,7 @@ Required properties:
>  	"arm,arm11mpcore-pmu"
>  	"arm,arm1176-pmu"
>  	"arm,arm1136-pmu"
> +	"qcom,krait-pmu"
>  - interrupts : 1 combined interrupt or 1 per core.

Might be worth updating the part about interrupts too, given that you've
added PPI support.

Will
