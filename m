From: ynvich@gmail.com (Sergei Ianovich)
Date: Mon, 09 Dec 2013 22:44:41 +0400
Subject: [PATCH 0/9] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <201312090251.45207.arnd@arndb.de>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312090251.45207.arnd@arndb.de>
Message-ID: <1386614681.7152.189.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-09 at 02:51 +0100, Arnd Bergmann wrote:
> On Sunday 08 December 2013, Sergei Ianovich wrote:
> > 
> > Except for defconfig, this is a completely new series. The first
> > eight patches fix outstanding issues with device tree support
> > in PXA. The 9th boots ICP DAS LP-8x4x.
> 
> Awesome! That was very quick. The main comment I have is for the
> dmaengine support, you will need to rebase on Daniel's patches for
> that. I also found few minor details.

Thanks for review.

I've applied and tested changes to meet review remarks for all patches,
except 5/9. However, there is no point to respin the series until the
decision about DMA is made.

Daniel, could please CC me when you post update pxa-dma series?
