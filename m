From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 22 Mar 2017 09:41:36 +0530
Subject: [PATCH 07/15] ARM: dts: spear13xx: fix PCI bus dtc warnings
In-Reply-To: <20170322020313.24338-7-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-7-robh@kernel.org>
Message-ID: <20170322041136.GU25659@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-03-17, 21:03, Rob Herring wrote:
> dtc recently added PCI bus checks. Fix these warnings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants 
> to take the whole lot.
> 
>  arch/arm/boot/dts/spear1310.dtsi | 3 +++
>  arch/arm/boot/dts/spear1340.dtsi | 1 +
>  2 files changed, 4 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
