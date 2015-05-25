From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 25 May 2015 08:05:06 +0200
Subject: [PATCHv1 0/2] Adding driver for Xilinx LogiCORE IP mailbox.
In-Reply-To: <1432317791-26851-1-git-send-email-moritz.fischer@ettus.com>
References: <1432317791-26851-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <5562BB92.60808@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2015 08:03 PM, Moritz Fischer wrote:
> This patchset adds mailbox framework integration for the Xilinx LogiCORE IP
> mailbox.  The Xilinx LogiCORE IP mailbox is a fpga softcore that allows
> interprocessor communication between AXI4 stream / memory mapped
> processors.
> 
> Changes from v0:
> ---------------------
> 
> - Several stylistic issues
> - Dropped superfluous intr_mode member
> - Really masking the IRQs on mailbox_shutdown
> - No longer using polling by accident in non-IRQ mode
> - Swapped doc and driver commits

Changes update should be in every particular patch.
Also v1 is used to the first version that's why this one should be v2.

Thanks,
Michal
