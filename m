From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 20 Jan 2015 08:13:57 +0000 (UTC)
Subject: [RFC/PATCH] arm: omap: hwmod: add debugfs interface
In-Reply-To: <alpine.DEB.2.02.1501200515370.5450@utopia.booyaka.com>
References: <1417818672-11586-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501200515370.5450@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1501200810270.5450@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jan 2015, Paul Walmsley wrote:

> On Fri, 5 Dec 2014, Felipe Balbi wrote:
> 
> > By exposing the details of hwmod structures
> > to debugfs we can much more easily verify
> > that changes to hwmod data is correct and won't
> > cause regressions.
> > 
> > The idea is that this can be used to check the
> > state of one hwmod, verify hwmod sysc fields, etc.
> > 
> > For example, this will be used to move some of
> > the sysc fields to DT and later verify that they
> > are correct pre- and post-patch.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> This one had a bunch of unnecessary includes and checkpatch issues 
> (below).  I cleaned those up here and have queued the result (also below) 
> for v3.20.

... and, the patch doesn't even boot.  Dropped.

If you really want something like this to be merged, resend a version that 
boots, and has checkpatch warnings fixed and unnecessary includes dropped.  
Otherwise you're just wasting my time.


- Paul
