From: rjui@broadcom.com (Ray Jui)
Date: Tue, 12 May 2015 15:05:13 -0700
Subject: [PATCH 0/2] PCI: iproc: add bcma PCIe 2.0 controller
In-Reply-To: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
Message-ID: <55527919.2030206@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hauke,

On 5/12/2015 2:22 PM, Hauke Mehrtens wrote:
> After Ray submitted the PCIe controller for the iProc devices using 
> pure device tree this adds support for the devices using bcma to scan 
> the bus. This should replaces the driver I initially send for inclusion.
> 
> @Ray The driver found in the Broadcom SDK does some more stuff:
> * setting up some DMA memory areas
> * chaining MPS and MRRS to 512
> * PHY changes:
>  * "improving" the PCIe jitter 
>  * some special initializations for the 3rd PCIe port
> 
> For me it works without these additions, but I haven't tested for 
> performance or stability or 3rd port. Can you check if this is needed 
> at all for the devices found on the market?

Good work, Hauke!

I'll eventually get to these. It may take a while but I'll eventually
get to them.

Thanks,

Ray
