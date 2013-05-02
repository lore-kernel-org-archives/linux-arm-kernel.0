From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 20:16:03 +0200
Subject: [PATCH, RFC 18/22] Xen: SWIOTLB is only used on x86
In-Reply-To: <20130502181309.GA23642@phenom.dumpdata.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.02.1305021638100.5398@kaball.uk.xensource.com>
 <20130502181309.GA23642@phenom.dumpdata.com>
Message-ID: <201305022016.03332.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Konrad Rzeszutek Wilk wrote:
> On Thu, May 02, 2013 at 04:38:50PM +0100, Stefano Stabellini wrote:
> > On Thu, 2 May 2013, Arnd Bergmann wrote:
> > > Enabling SWIOTLB_XEN on ARM results in build errors because the
> > > underlying SWIOTLB is only available on X86:
> > > 
> > > drivers/xen/swiotlb-xen.c: In function 'is_xen_swiotlb_buffer':
> > > drivers/xen/swiotlb-xen.c:105:2: error: implicit declaration of function 'mfn_to_local_pfn
> > > 
> > > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> Acked as well. Should I pull this in or Arnd are you OK with taking
> with my our Acks?

I'd prefer you to take it through your tree.

Thanks,

	Arnd
