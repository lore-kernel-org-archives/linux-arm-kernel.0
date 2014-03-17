From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 17 Mar 2014 10:59:24 -0500
Subject: [GIT PULL v2] SOCFPGA updates for 3.15, version 2
In-Reply-To: <201403171431.05666.arnd@arndb.de>
References: <1394427333-9028-1-git-send-email-dinguyen@altera.com>
 <201403171038.16362.arnd@arndb.de> <864n2xx9c7.fsf@void.printf.net>
 <201403171431.05666.arnd@arndb.de>
Message-ID: <1395071964.16340.3.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-03-17 at 14:31 +0100, Arnd Bergmann wrote:
> On Monday 17 March 2014, Chris Ball wrote:
> > On Mon, Mar 17 2014, Arnd Bergmann wrote:
> > > Chris, it would be nice if you could revert d9c3f5df539a "dts: socfpga: Add
> > > support for SD/MMC on the SOCFPGA platform" in your mmc tree now. The
> > > commit is now also present in arm-soc where it belongs, and we will get
> > > a merge conflict if we both carry it, due to the screwup on the
> > > sysmgr node.
> > 
> > I see, sorry about this.  I've pushed the revert to mmc-next now.
> > 
> 
> Ok, thanks!
> 

I apologize for causing the conflict, promise to be more aware this
these issues in the future.

Dinh
> 	Arnd
