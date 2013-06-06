From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 6 Jun 2013 04:00:39 +0000 (UTC)
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq, dma and addr info
 clean up
In-Reply-To: <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Santosh Shilimkar wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> AM33XX only supports DT boot mode and with addition of
> extracting module resources like, irq, dma and address space
> from DT block, so now we can remove duplicate information from
> hwmod data file.

OK, guess I'll take your word for it that it all works.  The
BeagleBone-white with appended DTB hasn't booted here since v3.7.
And the BeagleBone-black with discrete DTB doesn't boot at all with
current mainline, only with the TI vendor kernel & DTB...

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
