From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 2 Jan 2017 14:35:38 +0100
Subject: [PATCH v2] ARM64: zynqmp: Fix i2c node's compatible string
In-Reply-To: <20161222172740.7eieploc3kp5lunx@xsjsorenbubuntu.xilinx.com>
References: <1482427165-8951-1-git-send-email-mdf@kernel.org>
 <20161222172740.7eieploc3kp5lunx@xsjsorenbubuntu.xilinx.com>
Message-ID: <5b6514b5-dcc8-4478-90df-57d1aa7040e4@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.12.2016 18:27, S?ren Brinkmann wrote:
> On Thu, 2016-12-22 at 09:19:25 -0800, mdf at kernel.org wrote:
>> From: Moritz Fischer <mdf@kernel.org>
>>
>> The Zynq Ultrascale MP uses version 1.4 of the Cadence IP core
>> which fixes some silicon bugs that needed software workarounds
>> in Version 1.0 that was used on Zynq systems.
>>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> 
> 	S?ren
> 

Applied and send as the part of PR to arm-soc guys.

Thanks,
Michal
