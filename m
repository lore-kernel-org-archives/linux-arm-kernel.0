From: chanho61.park@samsung.com (Chanho Park)
Date: Fri, 28 Mar 2014 16:15:28 +0900
Subject: disabling MMU of ARMv7-A
Message-ID: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I want to know is there anyone who tried disabling MMU of ARMv7-A likes
cortex-a9.
Yes. I know this is a silly question :)
I turned off CONFIG_MMU option of my exynos4 board and specified
CONFIG_DRAM_BASE/SIZE and REMAP_VECTORS_TO_RAM.
The problem is occurred in here there is no way to specify the vector table
address.
As I know the cortex-M3/4 has VTOR(Vector table offset register) to specify
the vector table address.
However, ARMv7-A/R doesn't have such register. They can only control whether
use _HIGH_ vector or not.
In this situation, can I find a way to boot successfully with
nommu+cortex-a9?

Thanks.

Best Regards,
Chanho Park
