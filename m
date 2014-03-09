From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Mar 2014 23:28:04 -0800
Subject: [GIT PULL] SOCFPGA updates for 3.15
In-Reply-To: <20140309055611.GF12854@quad.lixom.net>
References: <1393472077-16220-1-git-send-email-dinguyen@altera.com>
 <20140309055611.GF12854@quad.lixom.net>
Message-ID: <20140309072804.GJ16310@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 08, 2014 at 09:56:11PM -0800, Olof Johansson wrote:
> On Wed, Feb 26, 2014 at 09:34:37PM -0600, dinguyen at altera.com wrote:
> > Hi Arnd, Kevin and Olof,
> > 
> > Please consider pulling in these patches for v3.15.
> > 
> > Thanks,
> > Dinh
> > 
> > The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:
> > 
> >   Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_updates_for_3.15
> > 
> > for you to fetch changes up to 1b60b9fac9c56488f78aa4396301757d37e586e7:
> > 
> >   dts: socfpga: Update clock entry to support multiple parents (2014-02-26 21:12:51 -0600)
> 
> Hi,
> 
> Merged into next/drivers.

This caused build failures when building dtb targets:

ERROR (phandle_references): Reference to non-existent node or label "sysmgr"
ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: *** [arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb] Error 2

And others.

Please fix and respin; I've dropped the branch.


-Olof
