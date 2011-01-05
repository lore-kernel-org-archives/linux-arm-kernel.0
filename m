From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Jan 2011 16:26:27 +0200
Subject: OMAP4 panda gets stuck during reboot
In-Reply-To: <7f40d94c30aa807513e7cdbc097a5caf@mail.gmail.com>
References: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
	<45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
	<20110105141814.GF2304@legolas.emea.dhcp.ti.com>
	<7f40d94c30aa807513e7cdbc097a5caf@mail.gmail.com>
Message-ID: <20110105142627.GG2304@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 05, 2011 at 07:52:34PM +0530, Santosh Shilimkar wrote:
> > On Wed, Jan 05, 2011 at 07:44:31PM +0530, Santosh Shilimkar wrote:
> > > > What could it be ? Any more debugging I could do to help ?
> > > >
> > > This is known and seems to OMAP specific issue. Test patch and
> >
> > Doesn't look like omap-specific from patch description. Looks like
> > like
> > CPU1 is turned off and the instruction to flush PMD entry fails.
> > Could
> > it be that all ARM SMPs are affected ?
> >
> Thread is broken some how. There were more emails on this one...
> Russell confirmed that he don't see the issue on his A9 Versatile
> platform and no one else complained except OMAP.

I see...

> Copy pasting some last updates..

Just finished reading the thread. Quite a problem on our side :-(

-- 
balbi
