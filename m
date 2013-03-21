From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 21 Mar 2013 14:46:41 -0400
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <201303211730.23247.arnd@arndb.de>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
Message-ID: <20130321184641.GB13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:30:23PM +0000, Arnd Bergmann wrote:
> On Thursday 21 March 2013, Thomas Petazzoni wrote:
> > Changes since v2:
> > 
> >  * Remove the DT binding, and use the mvebu_mbus_init() function call
> >    in all Marvell EBU SoC families. Requested by Arnd Bergmann.
> > 
> >  * Fix the MV78xx0 code, after reports of issues by Gregory Clement
> >    when testing on this platform.
> > 
> >  * Remove the 3 patches that have been merged by Arnd in
> >    arm-soc/mvebu-cleanup.
> > 
> 
> Thanks for the update
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

And thanks for turning this around so quickly Thomas, I'll pull it in
tonight or tomorrow.  Hopefully pcie goes smoothly as well.

thx,

Jason.
