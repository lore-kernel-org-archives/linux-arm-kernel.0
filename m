From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Aug 2011 01:32:19 +0300
Subject: [PATCH 1/2] I2C: OMAP: remove unneccesary use of pdev
In-Reply-To: <1312394960-21689-2-git-send-email-khilman@ti.com>
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
	<1312394960-21689-2-git-send-email-khilman@ti.com>
Message-ID: <20110803223219.GA4036@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 03, 2011 at 11:09:19AM -0700, Kevin Hilman wrote:
> A pointer to the struct device associated with the i2c device is
> already kept in the struct omap_i2c_dev, so use omap_i2c_device to
> find the pointer to struct device.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Definitely :-)

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110804/7cf6b5c0/attachment.sig>
