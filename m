From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 20 Mar 2013 23:36:22 +0530
Subject: [PATCH 3/4] ARM: tegra: dalmore: add dt node for TPS65090's
 regulators
In-Reply-To: <5149EA8F.6090806@nvidia.com>
References: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
 <1363787070-14801-4-git-send-email-ldewangan@nvidia.com>
 <5149EA8F.6090806@nvidia.com>
Message-ID: <5149FA9E.6010702@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 March 2013 10:27 PM, Rhyland Klein wrote:
> On 3/20/2013 9:44 AM, Laxman Dewangan wrote:
> +			regulators {
> +				dcdc1 {
> +					regulator-name = "vdd-sys-5v0";
> +					regulator-always-on;
> +					regulator-boot-on;
> +				};
> You should also add the tps65090_dcdc1_reg label to dcdc1. I believe you
> make use of it in patch 4 and this currently causes build breaks.
>

Actually patch 4 uses this label and I should add on patch 4, not on 
patch 3.

I removed from patch3 and when cherrypick the patch 4 from different 
branch to make the patches, I missed the change and hence patch 4 is not 
getting compiled.

I will fix the issue on next revision.

Sorry for messing up and thins for pointing this.
