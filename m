From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Jun 2014 13:04:57 +0200
Subject: [PATCH 0/4] ARM randconfig fixes for SCSI
In-Reply-To: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
Message-ID: <20140625110457.GD19181@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can I get another set of reviews for these?

On Thu, Jun 05, 2014 at 11:29:45PM +0200, Arnd Bergmann wrote:
> Hi James,
> 
> These are some fixes for ancient randconfig build bugs I
> ran into on ARM. Clearly none of these are urgent, but it
> would be nice to have them merged for 3.17 if they look
> good to you.
> 
> Arnd Bergmann (4):
>   [SCSI] Don't build AdvanSys on ARM
>   [SCSI] pas16: don't call free_dma()
>   [SCSI] qlogicfas: don't call free_dma()
>   [SCSI] NCR53c406a: don't call free_dma() by default
> 
>  drivers/scsi/Kconfig      | 2 +-
>  drivers/scsi/NCR53c406a.c | 2 +-
>  drivers/scsi/pas16.c      | 2 --
>  drivers/scsi/qlogicfas.c  | 2 --
>  4 files changed, 2 insertions(+), 6 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
