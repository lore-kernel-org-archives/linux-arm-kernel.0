From: patch-notifications@ellerman.id.au (Michael Ellerman)
Date: Mon, 15 Oct 2018 15:01:03 +1100 (AEDT)
Subject: [v3,01/24] powerpc/32: Add ioremap_wt() and ioremap_coherent()
In-Reply-To: <c454a5dbb215719991e3b0e6470309101d870fbb.1539092111.git.christophe.leroy@c-s.fr>
Message-ID: <42YPr02vcGz9s7W@ozlabs.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-10-09 at 13:51:33 UTC, Christophe Leroy wrote:
> Other arches have ioremap_wt() to map IO areas write-through.
> Implement it on PPC as well in order to avoid drivers using
> __ioremap(_PAGE_WRITETHRU)
> 
> Also implement ioremap_coherent() to avoid drivers using
> __ioremap(_PAGE_COHERENT)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/86c391bd5f47101acf1f3e0abd9fe0

cheers
