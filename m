From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Mar 2017 15:56:55 +0000
Subject: [PATCH] arm64: struct debug_info: Check CONFIG_HAVE_HW_BREAKPOINT
In-Reply-To: <20170316221043.GA29802@credmon.mdns.org>
References: <20170316221043.GA29802@credmon.mdns.org>
Message-ID: <20170321155655.GB21829@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 06:10:43PM -0400, Chris Redmon wrote:
> Check if CONFIG_HAVE_HW_BREAKPOINT is enabled before compiling in extra
> data required for hardware breakpoints. Compiling out this code when hw
> breakpoints are disabled saves about 272 bytes per struct task_struct.
> 
> Signed-off-by: Chris Redmon <credmonster@gmail.com>

Queued for 4.12. Thanks.

-- 
Catalin
