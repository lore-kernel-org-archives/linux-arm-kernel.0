From: horms@verge.net.au (Simon Horman)
Date: Tue, 18 Jun 2013 17:02:03 +0900
Subject: [PATCH 2/2] gpio-rcar: Remove #ifdef CONFIG_OF around
 OF-specific sections
In-Reply-To: <2696904.tcjoE5nNPq@avalon>
References: <1371496527-13149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1371496527-13149-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51BF612B.6030900@cogentembedded.com> <2696904.tcjoE5nNPq@avalon>
Message-ID: <20130618080203.GA4191@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 09:21:08PM +0200, Laurent Pinchart wrote:
> On Monday 17 June 2013 23:19:07 Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 06/17/2013 11:15 PM, Laurent Pinchart wrote:
> > > All functions and data types used by OF-specific code paths are declared
> > > in <linux/of.h> regardless of CONFIG_OF. Replace the #ifdef CONFIG_OF
> > > guard with a if(IS_SELECTED(CONFIG_OF)) and let the compiler optimize
> > 
> >     You're using IS_ENABLED() actually.
> 
> Oops. We should fix gcc to check the commit messages :-)
> 
> Simon, could you fix this while applying, or should I resubmit ?

Please re-spin, thanks.
