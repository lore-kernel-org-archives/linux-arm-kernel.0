From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Apr 2017 14:44:51 -0500
Subject: [PATCH v7 3/9] dt-bindings: perf: hisi: Add Devicetree bindings
 for Hisilicon SoC PMU
In-Reply-To: <1491303333-140338-1-git-send-email-anurup.m@huawei.com>
References: <1491303333-140338-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170413194451.jhi7c62iar5dqvyy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 06:55:33AM -0400, Anurup M wrote:
> 1) Device tree bindings for Hisilicon SoC PMU.
> 2) Add example for Hisilicon L3 cache and MN PMU.
> 3) Add child nodes of L3C and MN in djtag bindings example.
> 
> Signed-off-by: Anurup M <anurup.m@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  .../devicetree/bindings/arm/hisilicon/djtag.txt    | 29 +++++++
>  .../devicetree/bindings/arm/hisilicon/pmu.txt      | 93 ++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt

Acked-by: Rob Herring <robh@kernel.org>
