From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 30 Oct 2014 11:45:41 -0600
Subject: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
In-Reply-To: <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141030162552.GC26820@obsidianresearch.com>
 <20141030165246.GC2048@red-moon>
 <20141030170305.GE26820@obsidianresearch.com>
 <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
Message-ID: <20141030174541.GH26820@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 05:39:15PM +0000, Liviu Dudau wrote:

> But of_pci_get_host_bridge_resources() does not request the resources, it only
> creates them out of the DT ranges. If/when the driver decides the list of
> resources is correct and it can work with it can also request them and use
> whatever domain number allocation strategy it wants (auto-incrementing or DT
> based). So I don't think the global sequencing is broken here.

So how does mvebu now allocate a unique domain number per mvebu_pcie?

Which hw_pci callback should do that?

Jason
