From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 10 Dec 2015 08:02:05 +0100
Subject: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <20151209231921.GI31930@localhost>
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com>
 <20151209231921.GI31930@localhost>
Message-ID: <5669236D.30805@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 10.12.2015 00:19, Bjorn Helgaas wrote:
> [+cc Michal, Paul, Thierry, Stephen, Alexandre (see irq_dispose_mapping questions below)]
> 
> On Sun, Nov 29, 2015 at 05:33:53PM +0530, Bharat Kumar Gogada wrote:
>> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> This needs either a MAINTAINERS update or an ack from Michal (whose
> MAINTAINERS entry matches anything containing "xilinx").

We have done it in this way because driver owners are changing time to
time and my entry cover it that I can pass it to appropriate person who
is responsible for it.

For this Maintainers part here is my:
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
