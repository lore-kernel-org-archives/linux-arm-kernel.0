From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Mar 2015 18:54:49 +0000
Subject: [PATCHv3 0/5] arm-cci400: PMU monitoring support on ARM64
In-Reply-To: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150317185449.GF8399@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 03:18:50PM +0000, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This series enables the PMU monitoring support for CCI400 on ARM64.
> The existing CCI400 driver code is a mix of PMU driver and the MCPM
> driver code. The MCPM driver is only used on ARM(32) and contains
> arm32 assembly and hence can't be built on ARM64. This patch splits
> the code to
> 
>  - ARM_CCI400_PORT_CTRL driver - depends on ARM && V7
>  - ARM_CCI400_PMU driver

If you repost this with acks added and my feedback addressed, then I'm
happy to put together a branch for arm-soc along with your other CCI PMU
fix for event validation.

Will
