From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 16 Feb 2012 08:29:20 -0800
Subject: [PATCHv9 4/5] regulator: twl4030: add support for external
 voltage get/set
In-Reply-To: <1329388073-17879-5-git-send-email-t-kristo@ti.com>
References: <1329388073-17879-1-git-send-email-t-kristo@ti.com>
 <1329388073-17879-5-git-send-email-t-kristo@ti.com>
Message-ID: <20120216162919.GD3383@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 12:27:52PM +0200, Tero Kristo wrote:
> This is needed for SMPS regulators, which use the OMAP voltage
> processor for voltage get/set functions instead of the normal I2C
> channel. For this purpose, regulator_init_data->driver_data contents
> are expanded, it is now a struct which contains function pointers
> for the set/get voltage operations, a data pointer for these, and
> the previously used features bitmask.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120216/c2f5c412/attachment.sig>
