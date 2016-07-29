From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2016 10:19:32 +0100
Subject: Contributing to PXA2xx pinctrl Driver
In-Reply-To: <579B1E0F.9040601@zilogic.com>
References: <579B1E0F.9040601@zilogic.com>
Message-ID: <20160729091932.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 02:42:47PM +0530, Vijay Kumar B. wrote:
> Hi Everyone,
> I am looking at the pinctrl driver for drivers/pinctrl/pxa/pxa2xx.c. The
> driver in mainline git and pxa2xx git (rjarzmik/linux on github) seems to
> write to allocated memory rather than to registers.

Please explain why you think that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
