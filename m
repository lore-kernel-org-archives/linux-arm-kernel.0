From: fthain@telegraphics.com.au (Finn Thain)
Date: Thu, 26 Jun 2014 14:11:39 +1000 (EST)
Subject: [PATCH 0/4] ARM randconfig fixes for SCSI
In-Reply-To: <20140625110457.GD19181@infradead.org>
References: <1402003789-1990031-1-git-send-email-arnd@arndb.de>
 <20140625110457.GD19181@infradead.org>
Message-ID: <alpine.LNX.2.00.1406261340220.6206@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 25 Jun 2014, Christoph Hellwig wrote:

> Can I get another set of reviews for these?

Reviewed-by: Finn Thain <fthain@telegraphics.com.au>

(All four patches.)

> >   [SCSI] pas16: don't call free_dma()
> >   [SCSI] qlogicfas: don't call free_dma()

BTW, I found that the suprious free_dma() calls appeared in 2.5.73 when a 
generic release implementation was apparently added to drivers that lacked 
any release method.

--
