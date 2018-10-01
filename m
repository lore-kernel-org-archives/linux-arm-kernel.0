From: jan.kundrat@cesnet.cz (=?iso-8859-1?Q?Jan_Kundr=E1t?=)
Date: Mon, 01 Oct 2018 21:25:21 +0200
Subject: [PATCH] PCI: mvebu: Fix PCI I/O mapping creation sequence
In-Reply-To: <afee5e1a-4b5a-47f6-91a9-dfe5d041a388@cesnet.cz>
References: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
 <afee5e1a-4b5a-47f6-91a9-dfe5d041a388@cesnet.cz>
Message-ID: <3ced4629-5fed-4399-9ac4-2e570033e6af@cesnet.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Just a rebuild-and-boot test. We don't use any PCIe devices 
> yet, but I'll grab an ugly eBay converter and try this patch 
> with a normal PCIe card later.

The patch works. I can access an i210 over a miniPCIe -> PCIe adapter.

With kind regards,
Jan
