From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 30 Nov 2010 09:14:10 +0100
Subject: [PATCH] arm: Export dma_set_coherent_mask() implementations
In-Reply-To: <1290896043.3292.52.camel@localhost> (Ben Hutchings's message of
	"Sat, 27 Nov 2010 22:14:03 +0000")
References: <1290896043.3292.52.camel@localhost>
Message-ID: <m3r5e3ns8d.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Hutchings <ben@decadent.org.uk> writes:

> Commit 710224fa2750cf449c02dd115548acebfdd2c86a 'arm: fix "arm: fix
> pci_set_consistent_dma_mask for dmabounce devices"' made
> dma_set_coherent_mask() an extern function for some ARM platforms.
> Since this function is called from many drivers, it must be exported.

Imre already posted it, few weeks ago. Russell, is it ok if e.g. I send
it to Linus and maybe stable?
-- 
Krzysztof Halasa
