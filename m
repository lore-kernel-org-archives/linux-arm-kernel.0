From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 11 Nov 2009 10:55:43 -0500 (EST)
Subject: drivers/mtd/nand/orion_nand.c build failure with old ABI
In-Reply-To: <20091111153223.GA3688@deprecation.cyrius.com>
References: <20091111153223.GA3688@deprecation.cyrius.com>
Message-ID: <alpine.LFD.2.00.0911111054500.16711@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Nov 2009, Martin Michlmayr wrote:

> drivers/mtd/nand/orion_nand.c fails to build when EABI is not set:
> 
>   CC      drivers/mtd/nand/orion_nand.o
> /tmp/ccDFyfwN.s: Assembler messages:
> /tmp/ccDFyfwN.s:120: Error: first destination register must be even -- `ldrd r3,[ip]'
> make[3]: *** [drivers/mtd/nand/orion_nand.o] Error 1
> make[2]: *** [drivers/mtd/nand] Error 2

Grrrrr.  Let me think of a workaround.


Nicolas
