From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 25 Apr 2014 18:37:59 -0300
Subject: [PATCH] ARM: mvebu: Select HAVE_ARM_TWD only if SMP is enabled
In-Reply-To: <20140425212658.GD28159@titan.lakedaemon.net>
References: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140425212658.GD28159@titan.lakedaemon.net>
Message-ID: <20140425213759.GA1173@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 25, Jason Cooper wrote:
> On Thu, Apr 24, 2014 at 08:34:36AM -0300, Ezequiel Garcia wrote:
> > HAVE_ARM_TWD depends on SMP, so we should only select it if
> > SMP is enabled, as the others platforms do.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/mach-mvebu/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I just tried to apply this against mvebu/fixes.  It failed.  What did
> you base this against?
> 

This is a fix for the recent SMP support that you've merged in mvebu/soc.

In particular, it fixes:

[PATCH v3 08/11] ARM: mvebu: add SMP support for Armada 375 and Armada 38x

Yeah, I know: I wasn't really clear in the commit log. Sorry about that.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
