From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 2 Jun 2014 09:24:50 -0400
Subject: [PATCH v3 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <20140602063702.GB7834@dragon>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <20140602063702.GB7834@dragon>
Message-ID: <538C7B22.2020107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 02:37 AM, Shawn Guo wrote:
> On Thu, Apr 24, 2014 at 11:30:00AM -0400, Santosh Shilimkar wrote:
>> Here is an updated v3 of the series. Series introduces support for setting up
>> dma parameters based on device tree properties like 'dma-ranges' and
>> 'dma-coherent' and also update to ARM 32 bit port. Earlier version of the
>> series can be found here [3], [2] and [1].
> 
> Are these two generic device tree properties documented somewhere under
> Documentation/devicetree/bindings?
> 
These bindings have been already in use before this series. But looks like
they have not been documented. I will do a patch to add description for those
couple of parameters.

Regards,
Santosh
