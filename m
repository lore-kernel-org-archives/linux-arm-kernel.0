From: nm@ti.com (Nishanth Menon)
Date: Fri, 15 Dec 2017 07:38:00 -0600
Subject: [PATCH 2/8] ARM: dts: keystone*: Use a single soc0 instance
In-Reply-To: <20171215132102.435-3-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com> <20171215132102.435-3-nm@ti.com>
Message-ID: <1fce818d-f1a2-818d-7db8-d15a345f4c1e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Crap.. couple of typos crept in. Apologies - Santosh, if you dont want 
to manualy change, I can rebase and repost if you like to any branch 
of your choice.

On 12/15/2017 07:20 AM, Nishanth Menon wrote:
> Provide and soc0 node and reference the same to simplify dts. This also
            ^^ - should have been a
> resolves the following warnings when built with W=1:
> arch/arm/boot/dts/keystone-k2hk-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
> arch/arm/boot/dts/keystone-k2l-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
> arch/arm/boot/dts/keystone-k2e-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
> arch/arm/boot/dts/keystone-k2g-evm.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
> arch/arm/boot/dts/keystone-k2g-ice.dtb: Warning (unit_address_vs_reg): Node /soc has a reg or ranges property, but no unit name
> 
> NOTE: Though we can reformat files by reducing 1 level of indent due to
> the use of soc0 phandle, we ommit that change to prevent un-necessary
                               ^^ -> omit
> churn in code base.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>


Apologies once again on my oversight.

-- 
Regards,
Nishanth Menon
