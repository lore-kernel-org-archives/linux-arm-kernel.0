From: balbi@ti.com (Felipe Balbi)
Date: Mon, 20 Sep 2010 09:39:13 +0300
Subject: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
In-Reply-To: <4C91DF66.6020003@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
	<1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
	<20100916090018.GM3393@legolas.emea.dhcp.ti.com>
	<4C91DF66.6020003@compulab.co.il>
Message-ID: <20100920063913.GB32493@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 04:12:06AM -0500, Igor Grinberg wrote:
>Yes it will, but even if the hub reset gpio is for some reason unavailable,
>we don't want to disable ehci completely...

then you should set the gpio to an invalid number, otherwise you might
cause lots of WARN() to appear due to fiddling with unrequested gpio.

-- 
balbi
