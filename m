From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 17:25:00 +0100
Subject: [PATCH] ARM: dts: hummingboard: Remove unneeded 'fsl,mode'
 property
In-Reply-To: <1427889825-4349-1-git-send-email-festevam@gmail.com>
References: <1427889825-4349-1-git-send-email-festevam@gmail.com>
Message-ID: <20150401162500.GD24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 09:03:45AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx6qdl-hummingboard boards use sgtl5000 codec and the machine file 
> (imx-sgtl5000) already sets SSI in slave mode and codec in master mode, so there
> is no need for having the 'fsl,mode' property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Has this been tested at all?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
