From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jun 2010 19:35:42 +0900
Subject: [PATCH v5] libata: pata_samsung: Add Samsung PATA controller
	driver
In-Reply-To: <201006291529.45822.schindele@nentec.de>
References: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com>
	<201006291529.45822.schindele@nentec.de>
Message-ID: <016e01cb1840$00bea9e0$023bfda0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Juergen Schindele wrote:
> 
> Am Dienstag, 29. Juni 2010 schrieb Kukjin Kim:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based on
the
> > Libata subsystem and references the earlier patches sent for IDE
subsystem.
> Dear Kukjin Kim,

Hello, Juergen :-)

> as i had trouble with CF / trueIDE on PXA, have you read this thread ??
> <http://www.spinics.net/lists/arm-kernel/msg91461.html>
> Are you sure you dont need a "dcache_flush-page" ???
> Its just a thought to help you avoid problems.
> 
Thanks for your information.

Hmm..Abhilash and I have tested booting root fs on CF several times and
haven't found any problems yet.
Will test some more to make sure.

> Bye
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > ---
> >  drivers/ata/Kconfig           |    9 +
> >  drivers/ata/Makefile          |    1 +
> >  drivers/ata/pata_samsung_cf.c |  728
> +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 738 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/ata/pata_samsung_cf.c
> >

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
