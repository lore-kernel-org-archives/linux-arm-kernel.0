From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 19 May 2013 16:49:57 -0400
Subject: [PATCHv10 9/9] arm: mvebu: update defconfig with PCI and USB
 support
In-Reply-To: <1368719725-21265-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130519204957.GQ11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 05:55:24PM +0200, Thomas Petazzoni wrote:
> Now that we have the necessary drivers and Device Tree informations to
> support PCIe on Armada 370 and Armada XP, enable the CONFIG_PCI
> option.
> 
> Also, since the Armada 370 Mirabox has a built-in USB XHCI controller
> connected on the PCIe bus, enable the corresponding options as well.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig |    3 +++
>  1 file changed, 3 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
