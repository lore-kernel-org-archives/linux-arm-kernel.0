From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Jun 2013 10:29:55 -0400
Subject: [PATCH] arm: mvebu: enable mini-PCIe connectors on Armada 370 RD
In-Reply-To: <1371562661-7139-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371562661-7139-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130619142955.GB31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 03:37:41PM +0200, Thomas Petazzoni wrote:
> The Armada 370 RD board has two internal mini-PCIe connectors. This
> commit adds the necessary Device Tree informations to enable the usage
> of those mini-PCIe connectors.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/arm/boot/dts/armada-370-rd.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied to mvebu/dt

thx,

Jason.
