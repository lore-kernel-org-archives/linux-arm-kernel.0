From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 7 Sep 2016 09:11:05 -0700
Subject: [PATCH 0/5] Use mmio-sram driver for Keystone MSMC RAM
In-Reply-To: <20160901225846.31058-1-s-anna@ti.com>
References: <20160901225846.31058-1-s-anna@ti.com>
Message-ID: <d797bb0d-41b5-45a7-6faf-95baaab0215b@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On 9/1/2016 3:58 PM, Suman Anna wrote:
> Hi,
>
> The Keystone 2 family of SoCs have an on-chip RAM called the
> Multicore Shared Memory (MSM) RAM. This RAM is accessible through
> the Multicore Shared Memory Controller (MSMC). This series represents
> these on-chip RAMs as sram nodes so that the memory allocations
> can be managed by the in-kernel mmio-sram driver.
>
> The first 4 patches adds the basic SRAM nodes on each of the SoCs,
> and the last patch enables the generic on-chip SRAM driver for
> keystone defconfig.
>
The series looks good in general but I would like to understand
the users of this memory in kernel. Is that going to be posted
as a follow up patch ? Is the Power controller going to make
use of this SRAM for PM code ?

Regards,
Santosh
