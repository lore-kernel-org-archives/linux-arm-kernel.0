From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 5 Jun 2013 10:15:39 -0400 (EDT)
Subject: [RFC PATCH v2 0/2] drivers: mfd: Versatile Express SPC support
In-Reply-To: <1370432767-6620-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370432767-6620-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1306051008590.1200@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Jun 2013, Lorenzo Pieralisi wrote:

> This patch is v2 of a previous posting:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/170624.html
> 
> V2 changes:
> 
> - Dropped timeout interface patch
> - Converted interfaces to non-timeout ones, integrated and retested
> - Removed mutex used at init
> - Refactored code to work around init sections warning
> - Fixed interface type enumeration init
> - Fixed data write in SYSCFG write commands
> 
> This patch series introduces support for the Versatile Express Serial
> Power Controller (SPC) present in ARM Versatile Express TC2 core tiles.
> SPC driver is a fundamental component of TC2 power management and allows
> to carry out C-state management and DVFS for A15 and A7 clusters.
[...]

The MCPM backend for TC2 obviously depends on these patches and it 
should probably be merged via the ARM SoC tree.  Could those patches go 
with it as well?  If so, Samuel's ACK would be appreciated.


Nicolas
