From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 23 Jun 2017 17:13:16 +0800
Subject: next-20170621 build: 1 failures 7 warnings (next-20170621)
In-Reply-To: <20170621100440.vcaxagg4yjca2cv4@sirena.org.uk>
References: <E1dNcMp-0005RN-1w@optimist>
 <20170621100440.vcaxagg4yjca2cv4@sirena.org.uk>
Message-ID: <1498209196.26313.71.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for late reply, 

+Lorenzo

On Wed, 2017-06-21 at 18:04 +0800, Mark Brown wrote:
> On Wed, Jun 21, 2017 at 10:56:07AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm allmodconfig due to:
> 
> > 	arm-allmodconfig
> > ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]
> 
> caused by eaf3023b0498a (PCI: mediatek: Add MediaTek PCIe host
> controller support).


Hi Lorenzo,

I picked up your changes and had some modifications like what you did
for other platforms:

9f8e3a5 PCI: Add devm_pci_alloc_host_bridge() interface 
35a1a84 PCI: Add pci_free_host_bridge() interface
e33aafd PCI: Initialize bridge release function at bridge allocation

...and it looks Okay.

I have also noticed that you continue sending patches for other
platforms but I have not yet had a look in detail. I'm quite busy these
days and don't have time to dig it, hence it is becoming a little
unmanageable for me.

Did you have a chance to send the same patches for MediaTek?  I
appreciate that and I can help to test it on our platforms.


Ryder.
