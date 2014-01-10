From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Jan 2014 17:00:06 +0000
Subject: [PATCH v9 4/5] arm64: introduce CONFIG_PARAVIRT,
 PARAVIRT_TIME_ACCOUNTING and pv_time_ops
In-Reply-To: <1389292336-9292-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1401091755390.21510@kaball.uk.xensource.com>
 <1389292336-9292-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20140110170005.GH925@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 06:32:15PM +0000, Stefano Stabellini wrote:
> Introduce CONFIG_PARAVIRT and PARAVIRT_TIME_ACCOUNTING on ARM64.
> Necessary duplication of paravirt.h and paravirt.c with ARM.
> 
> The only paravirt interface supported is pv_time_ops.steal_clock, so no
> runtime pvops patching needed.
> 
> This allows us to make use of steal_account_process_tick for stolen
> ticks accounting.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: will.deacon at arm.com
> CC: nico at linaro.org
> CC: marc.zyngier at arm.com
> CC: cov at codeaurora.org
> CC: arnd at arndb.de
> CC: olof at lixom.net
> CC: Catalin.Marinas at arm.com

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
