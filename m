From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 11 Dec 2013 13:49:53 +0100
Subject: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation
 with COMPILE_TEST
In-Reply-To: <7787436.L49ODt45in@avalon>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131129105353.GI22771@ulmo.nvidia.com> <7787436.L49ODt45in@avalon>
Message-ID: <2487119.M3l3CLesSz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Friday 29 November 2013 14:51:25 Laurent Pinchart wrote:
> On Friday 29 November 2013 11:53:54 Thierry Reding wrote:
> > On Wed, Nov 27, 2013 at 02:18:33AM +0100, Laurent Pinchart wrote:
> > > This helps increasing build testing coverage.
> > > 
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: linux-pwm at vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > Acked-by: Simon Horman <horms@verge.net.au>
> > > ---
> > > 
> > >  drivers/pwm/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > I'm not sure if this has been answered in any of the various subthreads
> > before. I've tried to read through them, but I may have missed some. It
> > was mentioned that iowrite16() wasn't supported on all architectures;
> > won't this possibly cause randconfig autobuilders to break?
> 
> That's possible (although it has been reported to me that the situation got
> fixed on arch/cris in v3.12), but the only way to find out is to try it.
> That would be a bug in the architecture, and it should then get fixed.

Would you consider picking this patch up for v3.14 ?

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/fbaf304f/attachment.sig>
