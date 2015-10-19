From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Oct 2015 18:47:19 +0100
Subject: [PATCH] arm64: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <1442413401-2955-1-git-send-email-jszhang@marvell.com>
References: <1442413401-2955-1-git-send-email-jszhang@marvell.com>
Message-ID: <20151019174719.GG11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 10:23:21PM +0800, Jisheng Zhang wrote:
> Currently, if cpuidle is disabled or not supported, powertop reports
> zero wakeups and zero events. This is due to the cpu_idle tracepoints
> are missing.
> 
> This patch is to make cpu_idle tracepoints always available even if
> cpuidle is disabled or not supported.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Queued for 4.4. Thanks.

-- 
Catalin
