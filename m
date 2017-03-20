From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 20 Mar 2017 16:35:16 +0530
Subject: [PATCH 2/4] ARM: SPEAr: DT: Remove nonexistent properties
In-Reply-To: <20170320095721.6724-2-borneo.antonio@gmail.com>
References: <20170320095721.6724-1-borneo.antonio@gmail.com>
 <20170320095721.6724-2-borneo.antonio@gmail.com>
Message-ID: <20170320110516.GG25659@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-03-17, 10:57, Antonio Borneo wrote:
> The properties "pl022,hierarchy" and "pl022,slave-tx-disable" are
> not documented in DT binding and don't exist in the driver code.
> They have no effect and can be removed.
> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> To: Viresh Kumar <vireshk@kernel.org>
> To: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: linux-spi at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/boot/dts/spear1310-evb.dts | 6 ------
>  arch/arm/boot/dts/spear1340-evb.dts | 6 ------
>  2 files changed, 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
