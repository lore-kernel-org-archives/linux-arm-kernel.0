From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 Aug 2017 21:46:01 +0200
Subject: [PATCH v7 6/8] PCI: aardvark: Use PCI_NUM_INTX
In-Reply-To: <20170815190223.18807-7-paul.burton@imgtec.com>
References: <20170815190223.18807-1-paul.burton@imgtec.com>
 <20170815190223.18807-7-paul.burton@imgtec.com>
Message-ID: <20170815214601.6913e004@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 15 Aug 2017 12:02:21 -0700, Paul Burton wrote:
> Switch from using a custom LEGACY_IRQ_NUM macro to the generic
> PCI_NUM_INTX definition for the number of INTx interrupts.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pci at vger.kernel.org

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
