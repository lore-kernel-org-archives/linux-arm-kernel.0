From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Aug 2015 08:20:26 +0200
Subject: [PATCH v4 1/2] Documentation: dt: Add Xilinx zynqmp dma device
 tree binding documentation
In-Reply-To: <20150820061831.GB13546@localhost>
References: <1438831173-8761-1-git-send-email-punnaia@xilinx.com>
 <20150820055255.GZ13546@localhost>
 <CAGnW=BbjdAUf5SgRXvNNoamhuVjKC4miBUGSiV_s4+Byb0nzog@mail.gmail.com>
 <20150820061831.GB13546@localhost>
Message-ID: <55D571AA.1090102@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2015 08:18 AM, Vinod Koul wrote:
> On Thu, Aug 20, 2015 at 11:41:33AM +0530, punnaiah choudary kalluri wrote:
>>>> +- interrupts: Should contain DMA channel interrupt
>>> channel interrupt or interrupts, former says it is plural
>>
>> ZynqMP DMA has single interrupt for each channel So, that is the reason
>> i have explicitly mentioned it as interrupt ( not interrupts).
>>
>> Please let me know if you still want it to be plural.
> 
> The example had multiple values so plural sounds right
> 

I expect you are talking about this "interrupts = <0 117 4>;"

It is 3 cells format used on ARM based on gic spec which is on SPI
interrupt 117 active high level-sensitive

Documentation/devicetree/bindings/arm/gic.txt

Thanks,
Michal
