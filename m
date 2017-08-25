From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 25 Aug 2017 08:49:55 +0800
Subject: [PATCH v4 0/4] PCI: rockchip: Move PCIE_WAKE handling into
 rockchip pcie driver
In-Reply-To: <20170824165505.GM31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170822031934.8675-1-jeffy.chen@rock-chips.com>
 <20170824165505.GM31858@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <599F7433.4070606@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 08/25/2017 12:55 AM, Bjorn Helgaas wrote:
> Looking for acks from Shawn and Rob...
>
> And I'm not sure about the DT wake IRQ description.  That seems like it
> could potentially be generic than this Rockchip-specific proposal.
>
>
it looks like shawn already take the error handling patch into his 
series, so i'll remove that one in my next version.

i'll wait for those error handling patches to land, then rebase and 
resend this wake irq patches, thanks:)

>
