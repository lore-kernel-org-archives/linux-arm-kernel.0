From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 30 Mar 2013 14:18:12 +0100
Subject: [PATCH] Fix IXP4xx coherent allocations
In-Reply-To: <20130323.195740.2108147521543354261.davem@davemloft.net> (David
 Miller's message of "Sat, 23 Mar 2013 19:57:40 -0400 (EDT)")
References: <m3obe9lxil.fsf@intrepid.localdomain>
 <20130323.195740.2108147521543354261.davem@davemloft.net>
Message-ID: <m3li95f2ln.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Miller <davem@davemloft.net> writes:

>> ARM core code currently requires coherent DMA mask to be set.

> This requirement is not reasonable.
>
> The DMA API documentation clearly states what the default must be,
> and what drivers are guarenteed will be the default.

ARM people - what do you think?
-- 
Krzysztof Halasa
