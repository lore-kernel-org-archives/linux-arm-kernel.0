From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Apr 2014 17:35:45 +0100
Subject: [PATCH] arm64: Add missing Kconfig for CONFIG_STRICT_DEVMEM
In-Reply-To: <1396657850-14252-1-git-send-email-lauraa@codeaurora.org>
References: <1396657850-14252-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140407163545.GB8479@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 05, 2014 at 01:30:50AM +0100, Laura Abbott wrote:
> The Kconfig for CONFIG_STRICT_DEVMEM is missing despite being
> used in mmap.c. Add it.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Thanks. Applied.

-- 
Catalin
