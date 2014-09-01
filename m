From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 1 Sep 2014 22:35:18 +0800
Subject: [GIT PULL] MFD: ARM (IMX & R8): Immutable branch for Dialog
 Semiconductor - vendor prefix consolidation
In-Reply-To: <20140901133854.GA8796@lee--X1>
References: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
 <20140829091359.GF24579@lee--X1> <20140901132736.GG3135@dragon>
 <20140901133854.GA8796@lee--X1>
Message-ID: <20140901143517.GH3135@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 02:38:54PM +0100, Lee Jones wrote:
> On Mon, 01 Sep 2014, Shawn Guo wrote:
> > On Fri, Aug 29, 2014 at 10:13:59AM +0100, Lee Jones wrote:
> > > IMX and R8 sub-arch Maintainers,
> > > 
> > > The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
> > > 
> > >   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-arm-v3.18
> > > 
> > > for you to fetch changes up to bd597f47ca4bf7a522a0298a95c7f9b2f0a75b9e:
> > > 
> > >   devicetree: Dialog Semiconductor consolidate existing vendor prefixes to standardise on 'dlg' (2014-08-29 09:26:29 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD and some ARM sub-arch maintainers.
> > 
> > I assume that I need to pull it into my tree only when it turns out
> > there are merge conflicts, but otherwise it can just go through your
> > tree, right?
> 
> If someone realises there's a conflict the chances are we've already
> hacked someone off.  If the first person to realise is Linus during
> the merge-window, you'd have to go to the effort of re-spinning your
> pull-request.  Something else you'd probably like to avoid.

I think if there is a conflict, linux-next will firstly report.  But,
yes, pulling it in is the safest.
> 
> I would suggest for each affected Maintainer to pull this in.

Pulled it into imx/dt branch, thanks.

Shawn
