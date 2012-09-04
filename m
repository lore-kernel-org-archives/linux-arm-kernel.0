From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 04 Sep 2012 12:53:24 +0100
Subject: [PATCH 04/11] misc: Versatile Express display muxer driver
In-Reply-To: <201209032121.03306.arnd@arndb.de>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-5-git-send-email-pawel.moll@arm.com>
 <201209032121.03306.arnd@arndb.de>
Message-ID: <1346759604.2605.70.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-03 at 22:21 +0100, Arnd Bergmann wrote:
> On Monday 03 September 2012, Pawel Moll wrote:
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/vexpress.txt |   19 ++
> >  drivers/misc/vexpress/Makefile                     |    1 +
> >  drivers/misc/vexpress/display.c                    |  197 ++++++++++++++++++++
> >  3 files changed, 217 insertions(+)
> >  create mode 100644 drivers/misc/vexpress/display.c
> > 
> 
> Shouldn't this go into the drivers/video directory?

I sort of assumed that drivers/video contain frame buffer drivers only,
but now I see there are some "control modules" there as well. Fine with
me.

Cheers!

Pawel
