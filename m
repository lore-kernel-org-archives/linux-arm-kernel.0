From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2016 10:12:08 +0100
Subject: [PATCH v6 06/14] arm64, numa: rework numa_add_memblk()
In-Reply-To: <1461780436-27182-7-git-send-email-ddaney.cavm@gmail.com>
References: <1461780436-27182-1-git-send-email-ddaney.cavm@gmail.com>
 <1461780436-27182-7-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160511091207.GA3051@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 11:07:08AM -0700, David Daney wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Rework numa_add_memblk() to update the parameter "u64 size" to "u64
> end", this will make it consistent with x86 and simplifies the arm64
> ACPI NUMA code to be added later.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
