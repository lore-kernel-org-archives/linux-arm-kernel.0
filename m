From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 13 Apr 2017 12:07:07 +0200
Subject: [PATCH] [media] imx: csi: retain current field order and
 colorimetry setting as default
In-Reply-To: <6c22519f-64f8-7213-d458-23470bdd5ecd@xs4all.nl>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-22-git-send-email-steve_longerbeam@mentor.com>
 <1491486929.2392.29.camel@pengutronix.de>
 <0f9690f8-c7f6-59ff-9e3e-123af9972d4b@xs4all.nl>
 <1491490451.2392.70.camel@pengutronix.de>
 <59e72974-bfb0-6061-8b13-5f13f8723ba6@xs4all.nl>
 <1491494481.2392.102.camel@pengutronix.de>
 <6c22519f-64f8-7213-d458-23470bdd5ecd@xs4all.nl>
Message-ID: <1492078027.2383.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-04-12 at 09:03 +0200, Hans Verkuil wrote:
[...]
> >> Do you have a git tree with this patch? It is really hard to review without
> >> having the full imx-media-csi.c source.
> > 
> > The patch applies on top of
> > 
> >   https://github.com/slongerbeam/mediatree.git imx-media-staging-md-v14
> > 
> > I have uploaded a branch
> > 
> >   git://git.pengutronix.de/git/pza/linux imx-media-staging-md-v14+color
> > 
> > with the patch applied on top.
> > 
> >> I think one problem is that it is not clearly defined how subdevs and colorspace
> >> information should work.
> 
> Ah, having the full source helped.
> 
> Ignore my previous review, it was incorrect.

Ok.

> I'll have to think about this some more. I'll get back to this, but it may take some
> time since my vacation starts tomorrow. The spec is simply unclear about how to handle
> this so we have to come up with some guidelines.

Yes, please. Until then, have a nice vacation.

regards
Philipp
