From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 12:58:45 -0600
Subject: [PATCH v4 03/11] dt-bindings: perf: hisi: Add Devicetree
 bindings for Hisilicon SoC PMU
In-Reply-To: <1487530221-42431-1-git-send-email-anurup.m@huawei.com>
References: <1487530221-42431-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170227185845.f3ge2qijwye5rg2v@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 01:50:21PM -0500, Anurup M wrote:
> 1) Device tree bindings for Hisilicon SoC PMU.
> 2) Add example for Hisilicon L3 cache and MN PMU.
> 3) Add child nodes of L3C and MN in djtag bindings example.
> 
> Signed-off-by: Anurup M <anurup.m@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  .../devicetree/bindings/arm/hisilicon/djtag.txt    |  25 +++++
>  .../devicetree/bindings/arm/hisilicon/pmu.txt      | 103 +++++++++++++++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt

Acked-by: Rob Herring <robh@kernel.org>
