From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 9 May 2013 09:12:58 +0100
Subject: [Xen-devel] [PATCH v3 1/4] xen: move xen_setup_runstate_info
 and get_runstate_snapshot to drivers/xen/time.c
In-Reply-To: <alpine.DEB.2.02.1305081858220.18865@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305081446580.18865@kaball.uk.xensource.com>
 <1368027714-14506-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130508175444.GB2800@phenom.dumpdata.com>
 <alpine.DEB.2.02.1305081858220.18865@kaball.uk.xensource.com>
Message-ID: <1368087178.17285.87.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-05-08 at 19:13 +0100, Stefano Stabellini wrote:
> On Wed, 8 May 2013, Konrad Rzeszutek Wilk wrote:
> > On Wed, May 08, 2013 at 04:41:51PM +0100, Stefano Stabellini wrote:
> > > Changes in v2:
> > > - leave do_stolen_accounting in arch/x86/xen/time.c;
> > > - use the new common functions in arch/ia64/xen/time.c.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Acked-by: Ian Campbell <ian.campbell@citrix.com>
> > > CC: konrad.wilk at oracle.com
> > 
> > On the generic and x86 side it looks OK to me. I presume you did a sanity
> > check on x86 to make sure nothing was off?
> 
> Yep, it seems to work.
> However I couldn't even compile test the ia64 code.

The ia64 Xen on Linux support hasn't been touched since circa 2.6.35
AFAIK...

Ian.
