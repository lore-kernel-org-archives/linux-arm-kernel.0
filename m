From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Wed, 7 Nov 2018 11:19:04 +0800
Subject: [PATCH] PCI: mediatek: Use
 devm_of_pci_get_host_bridge_resources() to parse DT
In-Reply-To: <1541140583.10519.1.camel@mtkswgap22>
References: <1539833014-1738-1-git-send-email-honghui.zhang@mediatek.com>
 <1541140583.10519.1.camel@mtkswgap22>
Message-ID: <1541560744.11281.15.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-11-02 at 14:36 +0800, Ryder Lee wrote:
> On Thu, 2018-10-18 at 11:23 +0800, Honghui Zhang (???) wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > Use the devm_of_pci_get_host_bridge_resources() API in place of the PCI OF
> > DT parser.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 109 +++++++++------------------------
> >  1 file changed, 29 insertions(+), 80 deletions(-)
> > 
[......]
> > 
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> 

Hi, Lorenzo, could you help take a look at this patch?

Thanks.
