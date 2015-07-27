From: hch@lst.de (Christoph Hellwig)
Date: Mon, 27 Jul 2015 07:12:16 +0200
Subject: [PATCH v2 08/25] arch: introduce memremap()
In-Reply-To: <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023842.8664.97620.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150726172527.GA29513@lst.de>
 <CAPcyv4igoopDPpcCRU1TNYdwPhiYdcDiRA7L9Jdian=0rtexRg@mail.gmail.com>
Message-ID: <20150727051216.GA15836@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 26, 2015 at 10:49:39AM -0700, Dan Williams wrote:
> > What's the point of having this MEMREMAP_CACHE alias?
> 
> For developers that are used to seeing ioremap_cache()...

Meh.  We've got git logs that show clearly what replaced a previous API.
Duplicate names for the same API are highly confusing.
