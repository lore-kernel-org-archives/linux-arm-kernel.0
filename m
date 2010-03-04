From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 4 Mar 2010 17:15:38 +0000
Subject: Query about arm Dcache/Icache ?
In-Reply-To: <12E2D0F704624646AF3EE27EFBBD5321@dufan>
References: <12E2D0F704624646AF3EE27EFBBD5321@dufan>
Message-ID: <20100304171538.GB28495@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rocky wrote:
> 
>    Hi allJ
> 
>          >From ARM920T, cache is split into Icache and Dcache.
> 
>    Question: How does hardware know which part of binary program in
>    memory should loaded into Icache/Dcache?

It loads code into Icache when executing it, and it loads data into
Dcache when accessed by memory instructions.  Not very complicated :-)

(Some later ARMs can also load both speculatively,
which is a bit of a pain for DMA.)

-- Jamie
