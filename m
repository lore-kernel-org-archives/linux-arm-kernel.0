From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 15 Jun 2017 12:01:03 +0800
Subject: [PATCH 2/2] ACPI/IORT: Remove iort_node_match()
In-Reply-To: <20170614163713.14574-2-lorenzo.pieralisi@arm.com>
References: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
 <20170614163713.14574-2-lorenzo.pieralisi@arm.com>
Message-ID: <e1ee59e9-d4e9-d820-1a32-c5ce958702b7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/6/15 0:37, Lorenzo Pieralisi wrote:
> Commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
> probing") removed the linker section for IORT entries probing.
> 
> Since those IORT entries were the only iort_node_match() interface
> users, the iort_node_match() became obsolete and can then be removed.
> 
> Remove the ACPI IORT iort_node_match() interface from the kernel.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Nice catch,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
