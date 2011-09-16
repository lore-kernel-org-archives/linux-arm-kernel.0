From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 16 Sep 2011 14:26:02 +0100
Subject: [PATCH 0/19] removal of mach/vmalloc.h and generic optimizations
In-Reply-To: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
Message-ID: <20110916132602.GC3051@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 03:07:11AM -0400, Nicolas Pitre wrote:
> This patch series removes all instances of mach/vmalloc.h in order to
> have a more unified memory map across all ARM architectures.  To do so,
> the static mappings are moved inside the vmalloc area.  And finally this
> allows for a generic optimization to ioremap where static mappings are
> reused whenever possible, using common code instead of having this
> duplicated in a couple places.
> 
> This also provides a net reduction of more than 1200 lines of code.

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
