From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 25 Apr 2014 17:42:55 -0400
Subject: [PATCH] ARM: mvebu: Select HAVE_ARM_TWD only if SMP is enabled
In-Reply-To: <20140425213759.GA1173@arch.cereza>
References: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140425212658.GD28159@titan.lakedaemon.net>
 <20140425213759.GA1173@arch.cereza>
Message-ID: <20140425214255.GG28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 06:37:59PM -0300, Ezequiel Garcia wrote:
> On Apr 25, Jason Cooper wrote:
> > On Thu, Apr 24, 2014 at 08:34:36AM -0300, Ezequiel Garcia wrote:
> > > HAVE_ARM_TWD depends on SMP, so we should only select it if
> > > SMP is enabled, as the others platforms do.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-mvebu/Kconfig | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > I just tried to apply this against mvebu/fixes.  It failed.  What did
> > you base this against?
> > 
> 
> This is a fix for the recent SMP support that you've merged in mvebu/soc.

duh.  Sorry, I was moving fast and just recalled that you wanted this in
'soon'  which I thought meant for v3.15.  No problem then.

thx,

Jason.
