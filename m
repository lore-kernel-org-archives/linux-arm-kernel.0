From: phdm@macq.eu (Philippe De Muyter)
Date: Fri, 7 Feb 2014 11:51:06 +0100
Subject: emmc on imx6 sabresd
In-Reply-To: <20140206075748.GC3708@S2101-09.ap.freescale.net>
References: <20140129100321.GA32101@frolo.macqel>
 <20140206075748.GC3708@S2101-09.ap.freescale.net>
Message-ID: <20140207105106.GB7085@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Shawn,

On Thu, Feb 06, 2014 at 03:57:50PM +0800, Shawn Guo wrote:
> On Wed, Jan 29, 2014 at 11:03:21AM +0100, Philippe De Muyter wrote:
> > Hi Shawn,
> > 
> > I try to use the emmc on my sabresd board and on a similar custom board
> > using 3.13, and I have just discovered by reading Internet that it was
> > not supported up to some weeks ago.  Is there a git tree somewhere that
> > has a branch containing 3.13 or linux-next and all the fixes for emmc on
> > sabresd ?
> 
> I think it will just work if you apply the patch [1] on top of
> v3.14-rc1.
> 
> Shawn
> 
> [1] http://www.spinics.net/lists/linux-mmc/msg23039.html

As I could not wait till then, I cloned the cjb's mmc tree, extracted the needed
patches using 'git format-patch', and applied them to my (then) v3.13-rc8 tree
using 'git am'.  I can confirm that that works perfectly.

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
