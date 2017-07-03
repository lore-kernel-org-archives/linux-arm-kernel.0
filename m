From: greg@kroah.com (Greg KH)
Date: Mon, 3 Jul 2017 10:44:39 +0200
Subject: [STABLE REQ] mm/vmalloc.c: huge-vmap: fail gracefully on
 unexpected huge vmap mappings
In-Reply-To: <CAKv+Gu8yGfECvJj8NhvfqRzDGZ5FrATeQDJAcASot+u+hq31zw@mail.gmail.com>
References: <CAKv+Gu8yGfECvJj8NhvfqRzDGZ5FrATeQDJAcASot+u+hq31zw@mail.gmail.com>
Message-ID: <20170703084439.GC11757@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 02:36:46PM +0000, Ard Biesheuvel wrote:
> Please consider
> 
> 029c54b09599 mm/vmalloc.c: huge-vmap: fail gracefully on unexpected
> huge vmap mappings
> 
> for inclusion into the v4.9 and v4.11 stable trees. It prevents
> crashes on arm64 that may occur after commit 324420bf91f6 ("arm64: add
> support for ioremap() block mappings") was merged for v4.6.

Does not apply to the 4.9-stable tree, can you provide a backport for it
there?

thanks,

greg k-h
