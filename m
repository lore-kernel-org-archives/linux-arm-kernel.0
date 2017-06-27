From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Jun 2017 09:39:58 +0100
Subject: [PATCH] arm: perf: make of_device_ids const
In-Reply-To: <3838e744e5fb337a55a047661d682f67442c016a.1498542886.git.arvind.yadav.cs@gmail.com>
References: <3838e744e5fb337a55a047661d682f67442c016a.1498542886.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170627083958.GB5759@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 11:42:21AM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  arch/arm/kernel/perf_event_v6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is already queued in -next.

Will
