From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 10:25:18 -0500
Subject: [PATCH] ARM: dove: convert serial DT nodes to clocks property
In-Reply-To: <1359493186-25589-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1359493186-25589-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130216152518.GV14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:59:46PM +0100, Sebastian Hesselbarth wrote:
> of_serial now has support for using clocks property and we have
> a DT clock provider. This patch replaces the hard coded clock-frequency
> property with a clocks phandle to tclk.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/dove.dtsi |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to mvebu/dt

thx,

Jason.
