From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 21:57:39 +0100
Subject: [PATCH v2] MAINTAINERS: Add myself as reviewer for Zynq
In-Reply-To: <f506a31d4f3b47f7aa3d08cc653a0de5@BY2FFO11FD041.protection.gbl>
References: <1414081762-28886-1-git-send-email-soren.brinkmann@xilinx.com>
 <2e0177fec3e14239ba979cbc5e924a73@BN1BFFO11FD026.protection.gbl>
 <f506a31d4f3b47f7aa3d08cc653a0de5@BY2FFO11FD041.protection.gbl>
Message-ID: <31125258.WF8sFMxyCQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 October 2014 10:49:50 S?ren Brinkmann wrote:
> On Fri, 2014-10-24 at 10:45AM +0200, Michal Simek wrote:
> > On 10/24/2014 10:30 AM, Arnd Bergmann wrote:
> > > On Friday 24 October 2014 08:08:15 Michal Simek wrote:
> > >> On 10/23/2014 06:29 PM, Soren Brinkmann wrote:
> > >>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > >>> ---
> > >>> v2:
> > >>>  - I removed the additional 'F' entries
> > >>>
> > >>>  MAINTAINERS | 1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>> index 0484f2c526f0..8b49eeee5a27 100644
> > >>> --- a/MAINTAINERS
> > >>> +++ b/MAINTAINERS
> > >>> @@ -1543,6 +1543,7 @@ F:      arch/arm/mach-pxa/include/mach/z2.h
> > >>>  
> > >>>  ARM/ZYNQ ARCHITECTURE
> > >>>  M:   Michal Simek <michal.simek@xilinx.com>
> > >>> +R:   S?ren Brinkmann <soren.brinkmann@xilinx.com>
> > >>>  L:   linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > >>>  W:   http://wiki.xilinx.com
> > >>>  T:   git git://git.xilinx.com/linux-xlnx.git
> > >>>
> > >>
> > >> Applied.
> > >> IMHO: This can go through arm-soc tree.
> > > 
> > > Yes, a simple patch like this, you can forward to use with your
> > > Signed-off-by, or add an Ack and ask us to pick it up directly.
> > > 
> > > With the current timing, I can still pick it up as a fix for 3.18 if you
> > > like.
> > > 
> > 
> > Ok here is my
> > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > 
> > and please pick it up as fix directly to 3.18.
> 
> Thanks!

Added to fixes branch.

I've changed the subject line to "Add Soren as reviewer for Zynq",
since even though you are the author of the patch, that is a more
useful shortlog message.

	Arnd
