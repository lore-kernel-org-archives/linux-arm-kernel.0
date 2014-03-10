From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Mar 2014 17:47:46 +0900
Subject: [PATCH 00/12] ARM: shmobile: Rework include path for SoC files
In-Reply-To: <20140307023813.GG11702@verge.net.au>
References: <20140224054058.1143.14096.sendpatchset@w520>
 <20140307023813.GG11702@verge.net.au>
Message-ID: <20140310084740.GC24411@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 11:38:16AM +0900, Simon Horman wrote:
> On Mon, Feb 24, 2014 at 02:40:58PM +0900, Magnus Damm wrote:
> > ARM: shmobile: Rework include path for SoC files
> > 
> > [PATCH 01/12] ARM: shmobile: Add temporary include workaround
> > [PATCH 02/12] ARM: shmobile: Rework include path for sh7372
> > [PATCH 03/12] ARM: shmobile: Rework include path for sh73a0
> > [PATCH 04/12] ARM: shmobile: Rework include path for EMEV2
> > [PATCH 05/12] ARM: shmobile: Rework include path for r8a7740
> > [PATCH 06/12] ARM: shmobile: Rework include path for r8a7778
> > [PATCH 07/12] ARM: shmobile: Rework include path for r8a7779
> > [PATCH 08/12] ARM: shmobile: Rework include path for r8a7790
> > [PATCH 09/12] ARM: shmobile: Rework include path for r8a7791
> > [PATCH 10/12] ARM: shmobile: Rework include path for r8a73a4
> > [PATCH 11/12] ARM: shmobile: Rework include path for r7s72100
> > [PATCH 12/12] ARM: shmobile: Rework include path for common bits
> > 
> > Start converting the mach-shmobile subarchitecture from <mach/something.h>
> > to "something.h". This series covers shared code base and SoC code,
> > however actual header files are not moved yet. Upcoming series that
> > depend on this one will have to convert board code as well. When SoCs
> > code and board code have been converted then actual header files can
> > be moved and temporary include path workarounds can be removed.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Thanks, I have queued this up.

As Olof has indicated that he is not happy with the first patch of
the series I have dropped the entire series for now.
