From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 May 2012 10:02:15 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120529073334.GA12217@n2100.arm.linux.org.uk>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
 <20120529073334.GA12217@n2100.arm.linux.org.uk>
Message-ID: <20120529090215.GA3954@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 08:33:34AM +0100, Russell King - ARM Linux wrote:

> But, as I pointed out earlier, there's the issue of using the wrong
> struct device to allocate memory for the DMA engine.  That's something
> that my soc-dmaengine.c got _right_, and soc-dmaengine-pcm.c gets _wrong_.

What is the issue with the current code - it *looks* like you want to
use the component device for the DMA as the struct device with dmaengine
but I don't understand the issue that's created if we don't (and why
things appear to be working for people as they are).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120529/8bc51056/attachment.sig>
