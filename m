From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 18 Jul 2011 16:21:47 -0400 (EDT)
Subject: [PATCH] orion5x: fixup 5181 MPP mask check
In-Reply-To: <1311019512-26799-1-git-send-email-kaloz@openwrt.org>
References: <1311019512-26799-1-git-send-email-kaloz@openwrt.org>
Message-ID: <alpine.LFD.2.00.1107181619400.21187@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jul 2011, Imre Kaloz wrote:

> During the refactoring of the Orion MPP code, the detection for
> the 5181l as been used to select the 5181 MPP mask, which is wrong.
> Select the 5181 mask for all 5181 variants.
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Added to next/fixes of the linux-arm-soc.git repository.


Nicolas
