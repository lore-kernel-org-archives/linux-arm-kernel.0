From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 14:00:07 +0800
Subject: [GIT PULL] mxs: fixes for v3.2-rc
In-Reply-To: <201111232115.36143.arnd@arndb.de>
References: <20111117123740.GK14656@S2100-06.ap.freescale.net>
 <201111232115.36143.arnd@arndb.de>
Message-ID: <20111124060006.GE17979@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 09:15:35PM +0000, Arnd Bergmann wrote:
> On Thursday 17 November 2011, Shawn Guo wrote:
> > Hi Arnd,
> > 
> > Please pull the mxs fixes below for v3.2-rc.
> > 
> > Regards,
> > Shawn
> > 
> > The following changes since commit cfcfc9eca2bcbd26a8e206baeb005b055dbf8e37:
> > 
> >   Linux 3.2-rc2 (2011-11-15 15:02:59 -0200)
> > 
> > are available in the git repository at:
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/fixes
> > 
> > Shawn Guo (1):
> >       ARM: Update mach-types to fix mxs build breakage
> > 
> > Wolfram Sang (1):
> >       arm: mx28: fix bit operation in clock setting
> 
> 
> Hi Shawn,
> 
> Sorry for taking so long before I actually looked at this.
> 
> I've applied the fixes to the fixes branch for 3.2 but I noticed
> that Wolfram's patch was missing a 'Cc: stable at kernel.org' tag,
> which I added. Please confirm that this was correct so I can forward

Yes, this is correct.

> the patch, and make sure you add the stable tag where appropriate
> in the future (or explain why a patch should not be applied to the
> stable tree if it looks like it should).
> 
Ok, will do.

Regards,
Shawn
