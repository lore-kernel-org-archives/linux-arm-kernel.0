From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2015 18:37:48 +0000
Subject: [PATCH 1/2] arm64: cpufeature: declare enable_cpu_capabilities
 as static
In-Reply-To: <1445947555-2109-1-git-send-email-will.deacon@arm.com>
References: <1445947555-2109-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151028183748.GF8899@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 12:05:54PM +0000, Will Deacon wrote:
> enable_cpu_capabilities is only called from within cpufeature.c, so it
> can be declared static.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Both patches queued for 4.4. Thanks.

-- 
Catalin
