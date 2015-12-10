From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 10 Dec 2015 11:25:08 -0600
Subject: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <5669236D.30805@xilinx.com>
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com>
 <20151209231921.GI31930@localhost> <5669236D.30805@xilinx.com>
Message-ID: <20151210172508.GA367@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 08:02:05AM +0100, Michal Simek wrote:
> Hi Bjorn,
> 
> On 10.12.2015 00:19, Bjorn Helgaas wrote:
> > [+cc Michal, Paul, Thierry, Stephen, Alexandre (see irq_dispose_mapping questions below)]
> > 
> > On Sun, Nov 29, 2015 at 05:33:53PM +0530, Bharat Kumar Gogada wrote:
> >> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >>
> >> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> >> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> >> Acked-by: Rob Herring <robh@kernel.org>
> > 
> > This needs either a MAINTAINERS update or an ack from Michal (whose
> > MAINTAINERS entry matches anything containing "xilinx").
> 
> We have done it in this way because driver owners are changing time to
> time and my entry cover it that I can pass it to appropriate person who
> is responsible for it.
> 
> For this Maintainers part here is my:
> Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks.

For things under drivers/pci/host, I ask for an ack from the
individual maintainer before applying patches.  As-is (without a
MAINTAINERS update) I'll be looking for acks from you, Michal, for all
future changes to pcie-xilinx-nwl.c.  If you want something else, we
need a MAINTAINERS change.

Bjorn
