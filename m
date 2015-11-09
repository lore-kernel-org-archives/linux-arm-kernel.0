From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Nov 2015 18:14:22 +0000
Subject: [PATCH V2 0/2] arm64: cleanup FRAME_POINTER kconfig option and
 force to select it
In-Reply-To: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
References: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20151109181422.GE21606@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 09:43:55AM -0800, Yang Shi wrote:
> According to the discussion on the mailing list, this version adds a new patch
> to force select FRAME_POINTER for ARM64.
> 
> Change v2 --> v1:
> 1. Adds a new patch to force select FRAME_POINTER
> 2. Notes that this change adds a dependency on DEBUG_KERNEL for building with
> frame pointers
> 
> 
> Yang Shi (2):
>       arm64: remove redundant FRAME_POINTER kconfig option
>       arm64: force to select FRAME_POINTER

Do you really need two patches for this?

-- 
Catalin
