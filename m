From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 03 May 2010 16:23:41 -0400 (EDT)
Subject: [patch 0/2] Simtec kirkwood patches [resend]
In-Reply-To: <20100429231253.465019575@fluff.org.uk>
References: <20100429231253.465019575@fluff.org.uk>
Message-ID: <alpine.LFD.2.00.1005031619090.14468@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Apr 2010, Ben Dooks wrote:

> Simtec kirkwood patches, to the right list this time.

Could you change the order of your patches so that the 
kirkwood_nand_init_rnb is introduced last?

This way your new machine support could be merged without depending on a 
feature that is not yet merged through the MTD tree.


Nicolas
