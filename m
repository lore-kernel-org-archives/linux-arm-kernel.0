From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 20 Oct 2014 16:10:32 +0200
Subject: [PATCH v2 2/3] ARM: zynq: Enable generic allocator
In-Reply-To: <3551714.krTvviG9Ue@wuerfel>
References: <742a19eb987f3f99b42ba4b7e7ebc27bf19d7d72.1413811526.git.michal.simek@xilinx.com>
 <e5623273ff5d730b54c0c7dfe306dfbb98d4f058.1413811526.git.michal.simek@xilinx.com>
 <3551714.krTvviG9Ue@wuerfel>
Message-ID: <ab55e527012b44b4ba75d164116cf2bd@BN1BFFO11FD039.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 03:34 PM, Arnd Bergmann wrote:
> On Monday 20 October 2014 15:25:32 Michal Simek wrote:
>> Enable generic allocator by default because it is used by OCMC driver.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> 
> Why doesn't the driver select this then?

It can but currently OCM driver is enabled by default without Kconfig entry.

Appreciate your input on driver itself.
http://lists.openwall.net/linux-kernel/2014/10/06/196

Thanks,
Michal
