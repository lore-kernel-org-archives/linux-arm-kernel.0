From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 20:23:06 -0400
Subject: [PATCHv3 2/5] ata: ahci_mvebu: new driver for Marvell Armada
 380 AHCI interfaces
In-Reply-To: <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140426002306.GJ28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun,

On Tue, Apr 15, 2014 at 05:00:03PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 380 SoC includes two AHCI compatible
> interfaces. However, like all DMA-capable Marvell interface, they
> require special handling to configure MBus windows. Therefore, this
> commit adds a new ahci_mvebu driver, which relies on the
> libahci_platform.c code recently introduced.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
