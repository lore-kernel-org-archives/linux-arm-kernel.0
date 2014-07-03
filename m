From: balbi@ti.com (Felipe Balbi)
Date: Thu, 3 Jul 2014 18:33:21 -0500
Subject: [RESEND PATCH 1/2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <20140702032249.GA26010@saruman.home>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
 <1402676147-3711-2-git-send-email-balbi@ti.com>
 <20140613162323.GH8319@saruman.home>
 <alpine.DEB.2.02.1406131910060.340@utopia.booyaka.com>
 <20140702032249.GA26010@saruman.home>
Message-ID: <20140703233321.GB3655@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 10:22:49PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Jun 13, 2014 at 07:11:58PM +0000, Paul Walmsley wrote:
> > Hi Felipe, Tomi,
> > 
> > On Fri, 13 Jun 2014, Felipe Balbi wrote:
> > 
> > > On Fri, Jun 13, 2014 at 11:15:46AM -0500, Felipe Balbi wrote:
> > > > From: Sathya Prakash M R <sathyap@ti.com>
> > > > 
> > > > Add DSS hwmod data for AM43xx.
> > > > 
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Acked-by: Rajendra Nayak <rnayak@ti.com>
> > > > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > ---
> > > > 
> > > > Note that this patch was originally send on May 9th [1], changes were requested
> > > > and a new version was sent on May 19th [2], then on May 27th [3] Tomi pinged
> > > > maintainer again and go no response.
> > > > 
> > > > Without this patch, we cannot get display working on any AM437x devices.
> > > > 
> > > > [1] http://marc.info/?l=linux-arm-kernel&m=139963677925227&w=2
> > > > [2] http://marc.info/?l=linux-arm-kernel&m=140049799425512&w=2
> > > > [3] http://marc.info/?l=linux-arm-kernel&m=140117232826754&w=2
> > > > 
> > > >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 98 ++++++++++++++++++++++++++++++
> > > >  arch/arm/mach-omap2/prcm43xx.h             |  1 +
> > > >  2 files changed, 99 insertions(+)
> > 
> > Sorry for the delay on this.  Have been corresponding with TI management 
> > to figure out what to do about patches for AM43xx.  I don't have boards or 
> > public documentation for these devices, so it's impossible for me to 
> 
> documentation is now available publicly
> 
> http://www.ti.com/product/AM4379

at [1] you can find most (all?) board-related documentation. [2] will
give you AM437x GP EVM schematics.

[1] http://processors.wiki.ti.com/index.php/AM437X_EVM_Boards
[2] http://processors.wiki.ti.com/images/9/95/Am437x_gp_evm_3k0006_schematic_rev1_4a.pdf

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/b28692b0/attachment-0001.sig>
