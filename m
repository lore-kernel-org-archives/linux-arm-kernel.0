From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Feb 2011 12:26:12 +0200
Subject: [PATCH] omap4: usb: explicitly configure MUSB pads
In-Reply-To: <1297851135-25952-1-git-send-email-gadiyar@ti.com>
References: <1297851135-25952-1-git-send-email-gadiyar@ti.com>
Message-ID: <20110216102612.GQ2497@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 03:42:15PM +0530, Anand Gadiyar wrote:
> Use the mux framework APIs to explicitly configure
> the MUSB pads. The MUSB controller in OMAP4 can use
> either the old ULPI interface, or the new internal PHY.
> Configure the pads accordingly.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

applied to musb-next, will send a pull request for Tony by friday.

-- 
balbi
