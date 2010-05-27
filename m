From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 27 May 2010 09:57:14 +0100
Subject: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
In-Reply-To: <AANLkTikr8txaKEE0FO4d-nA-cpQv3zIQ8TALqM539fhz@mail.gmail.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
	<AANLkTikr8txaKEE0FO4d-nA-cpQv3zIQ8TALqM539fhz@mail.gmail.com>
Message-ID: <20100527085714.GK4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 05:43:47PM +0900, Jassi Brar wrote:
> On Thu, May 27, 2010 at 5:22 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based on the
> > Libata subsystem and references the earlier patches sent for IDE subsystem.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?drivers/ata/Kconfig ? ? ? ?| ? ?9 +
> > ?drivers/ata/Makefile ? ? ? | ? ?1 +
> > ?drivers/ata/pata_samsung.c | ?591
> 
> Fasten your seat belts before reading further....
> 
> Rather than generic 'samsung', I would suggest the driver named
> after the SoC, that is supported first(chronologically) in mainline kernel.
> All newer SoCs should be simply taken to contain the controller of that SoC.
> Otherwise, the same naming problem comes back to haunt us should
> Samsung decides to use a different IP in future SoCs. What would we
> call that driver? pata_samsung_v2.c ?

I'm not so bothered, but it could be pata_samsung_cfcon or anything,
a new block could be called pata_samsung_v2 or fred for all I really
care about this.
 
> my two sparks
> Jassi

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
