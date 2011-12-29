From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 29 Dec 2011 12:35:14 +0900
Subject: [PATCH] ARM: S3C64XX: Remove hsmmc1 from Cragganmore
In-Reply-To: <20111228130720.GA19755@sirena.org.uk>
References: <1325075179-17187-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111228123253.GJ24405@opensource.wolfsonmicro.com>
 <20111228130720.GA19755@sirena.org.uk>
Message-ID: <028c01ccc5da$e08162e0$a18428a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Wed, Dec 28, 2011 at 12:32:53PM +0000, Mark Brown wrote:
> > On Wed, Dec 28, 2011 at 12:26:19PM +0000, Mark Brown wrote:
> > > The second MMC slot was only present on revision 1 of Cragganmore so
> > > remove it. Only MMC0 and MMC2 are there on production systems.
> 
> > Sorry, ignore this - wrong slot.
> 
> Gah!  Actually I was right first time and got confused by some other
> bugs as I rebased onto -next.

Hahah, Mark, you need some refresh?

Anyway, looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
