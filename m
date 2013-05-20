From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 15:38:25 -0400
Subject: [PATCHv4 1/9] pci: mvebu: enable driver usage on Kirkwood
In-Reply-To: <1368625022-25243-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368625022-25243-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130520193825.GG31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 03:36:54PM +0200, Thomas Petazzoni wrote:
> We allow the pci-mvebu driver to be compiled on the Kirkwood platform,
> and add the 'marvell,kirkwood-pcie' as a compatible string supported
> by the driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/pci/mvebu-pci.txt          |    1 +
>  drivers/pci/host/Kconfig                           |    2 +-
>  drivers/pci/host/pci-mvebu.c                       |    1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Applied patches 1-8 to mvebu/pcie.

thx,

Jason.
