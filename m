From: tj@kernel.org (Tejun Heo)
Date: Sun, 4 May 2014 15:29:43 -0400
Subject: [PATCHv3 2/5] ata: ahci_mvebu: new driver for Marvell Armada 380
 AHCI interfaces
In-Reply-To: <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140504192943.GG26279@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:00:03PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 380 SoC includes two AHCI compatible
> interfaces. However, like all DMA-capable Marvell interface, they
> require special handling to configure MBus windows. Therefore, this
> commit adds a new ahci_mvebu driver, which relies on the
> libahci_platform.c code recently introduced.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-3.16.

Thanks.

-- 
tejun
