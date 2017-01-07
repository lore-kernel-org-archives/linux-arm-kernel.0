From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 7 Jan 2017 12:36:28 -0800
Subject: [PATCH v2 0/9] Use mmio-sram driver for Keystone MSMC RAM
In-Reply-To: <20170106215733.41637-1-s-anna@ti.com>
References: <20170106215733.41637-1-s-anna@ti.com>
Message-ID: <73a1577d-5e92-399c-8d93-59aa4cf7e3c3@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/6/17 1:57 PM, Suman Anna wrote:
> Hi,
>
> The Keystone 2 family of SoCs have an on-chip RAM called the
> Multicore Shared Memory (MSM) RAM. This RAM is accessible through
> the Multicore Shared Memory Controller (MSMC). This series represents
> these on-chip RAMs as sram nodes so that the memory allocations
> can be managed by the in-kernel mmio-sram driver.
>
> This is v2 of the previous series [1], and now includes 4 additional
> patches that reserve the portions of the MSMC RAM used by the
> Keystone Boot Monitor. The first 5 patches are essentially the same
> as in v1, with minor commit description updates for using the proper
> SoC names, but no code changes.
>
> Patches baselined on 4.10-rc1.
>
Applied. Should start showing up next soon. thanks !!

Regards,
Santosh
