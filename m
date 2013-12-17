From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 18:12:29 +0000
Subject: [PATCH 1/2] ARM64: check stack pointer in get_wchan
In-Reply-To: <20131205133010.16410.96824.stgit@buzz>
References: <20131205133010.16410.96824.stgit@buzz>
Message-ID: <20131217181228.GT32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 01:30:10PM +0000, Konstantin Khlebnikov wrote:
> get_wchan() is lockless. Task may wakeup at any time and change its own stack,
> thus each next stack frame may be overwritten and filled with random stuff.
> 
> Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>

Thanks. Applied (both patches).

-- 
Catalin
