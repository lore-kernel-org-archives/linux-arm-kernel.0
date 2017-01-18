From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Jan 2017 08:46:57 +0530
Subject: [PATCH v4 2/4] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <20170117131808.29798-3-d-gerlach@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-3-d-gerlach@ti.com>
Message-ID: <20170118031657.GB11478@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-01-17, 07:18, Dave Gerlach wrote:
> Add the device tree bindings document for the TI CPUFreq/OPP driver
> on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
> binding allows us to provide an opp-supported-hw property for each OPP
> to define when it is available. This driver is responsible for reading
> and parsing registers to determine which OPPs can be selectively enabled
> based on the specific SoC in use by matching against the opp-supported-hw
> data.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
> 	Update to simplify binding, only use "syscon" now to pass control
> 	module register space and let driver handle offsets.
> 
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
