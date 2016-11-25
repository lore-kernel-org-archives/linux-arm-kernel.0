From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Nov 2016 16:20:40 +0000
Subject: [PATCH v28 0/9] arm64: add kdump support
In-Reply-To: <20161124095523.6972-1-takahiro.akashi@linaro.org>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
Message-ID: <20161125162039.GB22099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 06:55:23PM +0900, AKASHI Takahiro wrote:
> AKASHI Takahiro (8):
>   arm64: kdump: reserve memory for crash dump kernel
>   memblock: add memblock_cap_memory_range()
>   arm64: limit memory regions based on DT property, usable-memory-range
>   arm64: kdump: implement machine_crash_shutdown()
>   arm64: kdump: add kdump support
>   arm64: kdump: add VMCOREINFO's for user-space coredump tools
>   arm64: kdump: enable kdump in the arm64 defconfig
>   arm64: kdump: update a kernel doc

Given that it's nearly -rc7, holiday in the US and more acks needed, we
should defer merging this series to 4.11. In the meantime, since Will is
going to handle the 4.11 merging window, I'm acking the whole series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
