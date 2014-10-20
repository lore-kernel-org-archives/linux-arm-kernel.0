From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 20 Oct 2014 15:14:34 +0200
Subject: [PATCH 1/3] ARM: zynq: Move common.h to generic location
In-Reply-To: <20141013202453.GQ13679@xsjandreislx>
References: <565908c2d70764e281d6a9b28d9599cea87823a3.1412595859.git.michal.simek@xilinx.com>
 <20141013202453.GQ13679@xsjandreislx>
Message-ID: <0f2fd0e26a34479ea7e12d49789cc485@BN1BFFO11FD051.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2014 10:24 PM, S?ren Brinkmann wrote:
> On Mon, 2014-10-06 at 01:44PM +0200, Michal Simek wrote:
>> include/soc/zynq/ is the right location for this header
>> to be able to share information from this header with other
>> drivers which require it.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  arch/arm/mach-zynq/common.c                       | 2 +-
>>  arch/arm/mach-zynq/hotplug.c                      | 2 +-
>>  arch/arm/mach-zynq/platsmp.c                      | 2 +-
>>  arch/arm/mach-zynq/slcr.c                         | 2 +-
> 
> In the 3.18 merge window arch/arm/mach-zynq/pm.c had been added which is
> not covered in this version of the patch.

Thanks will send v2.
Michal
