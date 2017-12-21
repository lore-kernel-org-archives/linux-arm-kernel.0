From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Thu, 21 Dec 2017 10:13:23 +0800
Subject: [PATCH v2 0/2] PCI: mediatek: Fixups for the IRQ handle routine
 and MT7622's class code
In-Reply-To: <1513822130-18213-1-git-send-email-honghui.zhang@mediatek.com>
References: <1513822130-18213-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1513822403.25872.3.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-21 at 10:08 +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Two fixups for mediatek's host bridge:
> The first patch fixup the IRQ handle routine to avoid IRQ reentry which
> may exist for both MT2712 and MT7622.
> The second patch fixup class type for MT7622.
> 

Sorry about the noise, to the wrong mail group, please ignore this.
thanks.

> Change Since v1:
>  - Add the second patch.
>  - Make the first patch's commit message more standard.
> 
> Honghui Zhang (2):
>   PCI: mediatek: Clear IRQ status after IRQ dispatched to avoid reentry
>   PCI: mediatek: Fixup class type for MT7622
> 
>  drivers/pci/host/pcie-mediatek.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
