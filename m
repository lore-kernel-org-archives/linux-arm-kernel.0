From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Mar 2014 14:31:05 +0100
Subject: [GIT PULL v2] SOCFPGA updates for 3.15, version 2
In-Reply-To: <864n2xx9c7.fsf@void.printf.net>
References: <1394427333-9028-1-git-send-email-dinguyen@altera.com>
 <201403171038.16362.arnd@arndb.de> <864n2xx9c7.fsf@void.printf.net>
Message-ID: <201403171431.05666.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 March 2014, Chris Ball wrote:
> On Mon, Mar 17 2014, Arnd Bergmann wrote:
> > Chris, it would be nice if you could revert d9c3f5df539a "dts: socfpga: Add
> > support for SD/MMC on the SOCFPGA platform" in your mmc tree now. The
> > commit is now also present in arm-soc where it belongs, and we will get
> > a merge conflict if we both carry it, due to the screwup on the
> > sysmgr node.
> 
> I see, sorry about this.  I've pushed the revert to mmc-next now.
> 

Ok, thanks!

	Arnd
