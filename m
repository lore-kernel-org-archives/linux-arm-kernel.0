From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 5 Jul 2011 12:51:41 +0200
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<20110704232758.GB12824@ponder.secretlab.ca>
	<00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
Message-ID: <201107051251.41653.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 5. Juli 2011, 09:05:32 schrieb Kukjin Kim:
[...]
> As a note, S3C24XX and S3C64XX include PL080 DMAC not PL330.
Are you sure the S3C24xx also uses a PL080?

At least for the 2416, the manual does not tell the type of DMA controller 
used. Also according to it it's a 6 channel controller where the pl080 has 8 
channels according to amba-pl08x.c .

So, to my untrained eye it looks like another type of controller - but I may 
be wrong.

Heiko
