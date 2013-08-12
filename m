From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 16:00:28 -0400
Subject: [PATCH 6/9] ARM: dove: update dove_defconfig with SI5351, PCI,
 and xHCI
In-Reply-To: <1376333215-12885-7-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-7-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130812200028.GV25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 08:46:52PM +0200, Sebastian Hesselbarth wrote:
> This adds SI5351 clock driver found on the SolidRun CuBox, PCI driver
> and USB 3.0 xHCI driver found on the Globalscale D3Plug to dove_defconfig.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/configs/dove_defconfig |    4 ++++
>  1 file changed, 4 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
