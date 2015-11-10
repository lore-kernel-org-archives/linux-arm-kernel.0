From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 10 Nov 2015 04:50:02 +0100
Subject: [PATCH] power: bq27xxx_battery: Add I2C module check dependency
 in Kconfig
In-Reply-To: <1447104183-13556-1-git-send-email-afd@ti.com>
References: <1447104183-13556-1-git-send-email-afd@ti.com>
Message-ID: <20151110035002.GB2712@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 09, 2015 at 03:23:03PM -0600, Andrew F. Davis wrote:
> Check if I2C core has been built as a module when BATTERY_BQ27XXX
> is built-in. If so disable I2C functionality.
> 
> Fixes: 6bd03ce3c12a ("power: bq27xxx_battery: Remove unneeded dependency in Kconfig")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151110/d3a5041c/attachment.sig>
