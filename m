From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 9 Feb 2017 10:01:33 -0600
Subject: [PATCH v6 2/4] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <20170209153549.8354-1-d-gerlach@ti.com>
References: <20170203172929.23940-3-d-gerlach@ti.com>
 <20170209153549.8354-1-d-gerlach@ti.com>
Message-ID: <CAL_Jsq+Vx=ypfUhCq4yAarZBcpX3vEBQGdma0gd5jB3qJBzPSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2017 at 9:35 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> Add the device tree bindings document for the TI CPUFreq/OPP driver
> on AM33xx, AM43xx, DRA7xx, and AM57xx SoCs. The operating-points-v2
> binding allows us to provide an opp-supported-hw property for each OPP
> to define when it is available. This driver is responsible for reading
> and parsing registers to determine which OPPs can be selectively enabled
> based on the specific SoC in use by matching against the opp-supported-hw
> data.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

Acked-by: Rob Herring <robh@kernel.org>

Rob
