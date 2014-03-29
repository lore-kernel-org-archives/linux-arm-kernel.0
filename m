From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Mar 2014 01:18:06 +0100
Subject: [PATCH net-next 0/3] net: stmmac: Add glue layer for socfpga
 platform
In-Reply-To: <1395891912-26855-1-git-send-email-dinguyen@altera.com>
References: <1395891912-26855-1-git-send-email-dinguyen@altera.com>
Message-ID: <201403290118.07163.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 March 2014, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Hi David,
> 
> I'm re-submitting the patch series to add the socfpga glue layer for the
> stmmac ethernet driver. My original patch did not build for kernel module,
> and I apologize for not testing against that.
> 
> This patch is also better aligned with the other stmmac glue
> layers(sti and sunxi).
> 
> I'd like to take the "net: stmmac: Add SOCFPGA glue driver" patch into your
> tree and the other 2 dts patches through the arm-soc tree.

I've applied patches 2 and 3 to the arm-soc/next/dt branch now.

Unfortunately there is still one trivial conflict against the net-next tree
left in the binding document, but I'm not too worried about that.

	Arnd
