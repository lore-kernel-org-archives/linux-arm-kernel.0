From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 16:04:52 -0400
Subject: [PATCH 7/9] ARM: dove: add PCIe controllers to SoC DT
In-Reply-To: <1376333215-12885-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130812200452.GW25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:46:53PM +0200, Sebastian Hesselbarth wrote:
> This adds a node for the pcie controllers found on Dove SoCs to the
> SoC DT include.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/boot/dts/dove.dtsi |   54 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

patches 7-9 applied to mvebu/dove_mbus since the dependencies are
cleaner that way.

thx,

Jason.
