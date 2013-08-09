From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 09 Aug 2013 15:58:40 +1000
Subject: [PATCHv8 00/10] MSI support for Marvell EBU PCIe driver
In-Reply-To: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1376027920.32100.11.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.

Appart from the build breakage when not using CONFIG_PCI_MSI which
I reported in a previous email, I'm fine with the series. No need
to add my acks to all of the ARM specific stuff.

Cheers,
Ben.
