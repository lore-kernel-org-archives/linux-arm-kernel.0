From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 11 Apr 2016 15:46:43 +0300
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <1460362846-2906-1-git-send-email-akurz@blala.de>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
Message-ID: <570B9CB3.2080101@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 4/11/2016 11:20 AM, Alexander Kurz wrote:

> With commit 7b91369b DMA access got disabled for device drivers with zero

    scripts/checkpatch.pl enforces certain commit citing style, your doesn't 
match it.

> DMA mask property. sdhci-esdhc-imx got blocked from DMA access by this.
> Hence: initialize the dma mask to enable access again.

    DMA -- please be consistent.

> Signed-off-by: Alexander Kurz <akurz@blala.de>
[...]

MBR, Sergei
