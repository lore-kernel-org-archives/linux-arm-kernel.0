From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 18 Jan 2018 22:25:05 +0800
Subject: [PATCH v4 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
In-Reply-To: <c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-9-jeffy.chen@rock-chips.com>
 <c188e6a9-744c-d984-545c-408607f35cc9@arm.com>
Message-ID: <5A60AE41.2050101@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 01/18/2018 08:27 PM, Robin Murphy wrote:
>>
>
> Is it worth using the clk_bulk_*() APIs for this? At a glance, most of
> the code being added here appears to duplicate what those functions
> already do (but I'm no clk API expert, for sure).
right, i think it's doable, the clk_bulk APIs are very helpful. i think 
we didn't use that is because this patch were wrote for the chromeos 4.4 
kernel, which doesn't have clk_bulk yet:)

will do it in the next version, thanks.
>
> Robin.
