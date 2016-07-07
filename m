From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 21:45:16 -0700
Subject: [PATCH v3 0/2] [for arm-soc] mach-tango updates for v4.8
In-Reply-To: <12902449.rg2TfjcyfJ@wuerfel>
References: <57726597.8030501@sigmadesigns.com> <577BA8DF.9080603@free.fr>
 <20160706035730.GA23212@localhost> <12902449.rg2TfjcyfJ@wuerfel>
Message-ID: <20160707044516.GA32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 10:04:42PM +0200, Arnd Bergmann wrote:
> On Tuesday, July 5, 2016 8:57:30 PM CEST Olof Johansson wrote:
> > On Tue, Jul 05, 2016 at 02:32:31PM +0200, Mason wrote:
> > > On 28/06/2016 13:55, Marc Gonzalez wrote:
> > > 
> > > > Hello arm-soc maintainers,
> > > > 
> > > > Could you please merge the following patches?
> > > > 
> > > > Marc Gonzalez (2):
> > > >   ARM: tango: add HOTPLUG_CPU support
> > > >   Update ARM/TANGO section
> > > 
> > > Hello Olof,
> > > 
> > > I see you've just merged a large number of patches in the for-next branch.
> > > https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/log/?h=for-next
> > > 
> > > I think you overlooked the two patches in this thread:
> > > 
> > > [PATCH v4 1/2] ARM: tango: add HOTPLUG_CPU support
> > > [PATCH v3 2/2] Update ARM/TANGO section
> > > 
> > > Could you merge these patches as well?
> > 
> > Yes, applied now. Thanks!
> 
> I ran into a build regression during randconfig testing, I think
> we should apply the patch below on top of next/soc:

Yep, applied.


-Olof
