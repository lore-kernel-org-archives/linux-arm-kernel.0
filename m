From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 11 Aug 2017 15:04:42 +0200
Subject: [PATCH 1/2] devicetree: ARM: zynq: Add DT binding for eFuse
 controller
In-Reply-To: <20170810182547.7c6qtfikzekfq7pq@rob-hp-laptop>
References: <4b4bfaad88f16d7229bf3da58be8f50f9d82a461.1501842586.git.michal.simek@xilinx.com>
 <20170810182547.7c6qtfikzekfq7pq@rob-hp-laptop>
Message-ID: <2c5bc4a3-8213-976f-89d9-9050f100357a@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.8.2017 20:25, Rob Herring wrote:
> On Fri, Aug 04, 2017 at 12:29:53PM +0200, Michal Simek wrote:
>> Add DT binding for eFuse controller available at Xilinx Zynq
>> SoC.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> ---
>>
>>  Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt | 15 +++++++++++++++
> 
> Move to bindings/nvmem with the other efuse bindings.
> 
> With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>

done in v2. I have added your line. Please let me know if you see any
problem.

Thanks,
Michal
