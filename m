From: b32955@freescale.com (Huang Shijie)
Date: Mon, 21 May 2012 16:29:18 +0800
Subject: [PATCH] GPMI-NAND: Define ecc.strength
In-Reply-To: <1337587991.2483.65.camel@sauron.fi.intel.com>
References: <1337571865-8016-1-git-send-email-marex@denx.de>
 <1337587991.2483.65.camel@sauron.fi.intel.com>
Message-ID: <4FB9FCDE.9070803@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?05?21? 16:13, Artem Bityutskiy ??:
> On Mon, 2012-05-21 at 05:44 +0200, Marek Vasut wrote:
>> The ecc.strength wasn't set, resulting in the following crash:
> How about ccing -stable? Can you find out which commit broke the driver?
>
The commit cfbc855b (mtd: nand:add sanity check of ecc strength to 
nand_scan_tail()

Huang Shijie
