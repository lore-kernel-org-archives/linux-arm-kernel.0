From: catalin.marinas@arm.com (catalin.marinas at arm.com)
Date: Wed, 30 Apr 2014 11:58:20 +0100
Subject: ARMv8: Allowing user space to perform cache-maintenance
In-Reply-To: <SNT151-W939A3657D532DA8406405DE8410@phx.gbl>
References: <SNT151-W6986D9EAC402142465B4BE8410@phx.gbl>
 <SNT151-W939A3657D532DA8406405DE8410@phx.gbl>
Message-ID: <20140430105820.GA31224@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:01:38PM +0530, Rajan Srivastava wrote:
> ARMv8 allows AArch64-EL0 to execute cache maintenance instructions
> (eg, by setting SCTLR_EL1.UCI). It looks like the current ARMv8 kernel
> doesn't support the above feature.

Where have you looked and came up to this conclusion?

-- 
Catalin
