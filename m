From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 25 Apr 2012 00:51:09 +0300
Subject: [PATCH 06/12] mmc: omap_hsmmc: remove private DMA API
 implementation
In-Reply-To: <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
 <E1SMLmF-0002WO-Ch@rmk-PC.arm.linux.org.uk>
Message-ID: <CANOLnOM29Mn2BTydX=C5FEu6evkS5W8eL87RwNmppJWuVLGjAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 7:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Remove the private DMA API implementation from omap_hsmmc, making it
> use entirely the DMA engine API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Since the driver becomes useless without DMA_ENGINE, we probably want
a 'depends on'?



-- 
Gra?vydas
