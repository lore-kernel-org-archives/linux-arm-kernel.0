From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Mar 2014 01:22:24 +0100
Subject: [PATCH 0/5] Kirkwood DT Documentation
In-Reply-To: <20140324002233.GZ15608@titan.lakedaemon.net>
References: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
 <20140324002233.GZ15608@titan.lakedaemon.net>
Message-ID: <201403290122.24713.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014, Jason Cooper wrote:
> arm-soc maintainers,
> 
> On Sat, Mar 22, 2014 at 01:45:55PM +0100, Andrew Lunn wrote:
> > This patchset fixes up a number of issues found by checkpatch in the
> > kirkwood DT files or binding Documentation. Vendor Prefixes are
> > documented, missing prefixes are added, incorrect prefixes are
> > corrected, and Kirkwood SoCs are documented.
> > 
> > Note that some of these patches contain UTF-8 characters, which the
> > mailing lists sometime don't like. The patches can also be found in
> > 
> > https://github.com/lunn/linux.git v3.14-rc7-next-20140321-dt
> > 
> > which is based on linux-next tag next-20140321.
> 
> I'd like to take this in as 'fixes-non-critical' for v3.15.  However,
> I'm having trouble finding a stable, conflict-free branch to base it on.
> The main problem seems to be vendor-prefixes.txt.
> 
> How would you prefer I handle this?  Or, would you guys just like to
> take the series directly?  I'm fine either way.
> 
> If taking directly,
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

I think Rob should take the binding changes, we can take the dts file
changes. Can you send them as patches relative to the next/dt branch
to arm at kernel.org?

	Arnd
