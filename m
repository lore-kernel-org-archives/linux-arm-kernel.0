From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Oct 2015 18:03:11 +0100
Subject: [PATCHv2 0/7] arm64: Use contiguous PTE bit for the kernel
 linear mapping
In-Reply-To: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
References: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20151005170310.GC5557@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 03:47:38PM -0500, Jeremy Linton wrote:
> Also, continuing thanks to Steve Capper who has been religiously
> testing these patch sets, and found a bug in the previous
> implementation.

Quick question: has this series been tested with CONFIG_DEBUG_RODATA
enabled?

-- 
Catalin
