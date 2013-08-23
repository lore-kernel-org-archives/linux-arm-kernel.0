From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 23 Aug 2013 10:52:03 +0200
Subject: [PATCH V3] i2c: move of helpers into the core
In-Reply-To: <1377187217-31820-1-git-send-email-wsa@the-dreams.de>
References: <1377187217-31820-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20130823085203.GC3035@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 06:00:14PM +0200, Wolfram Sang wrote:
> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
> that it is much cleaner to have this in the core. This also removes a
> circular dependency between the helpers and the core, and so we can
> finally register child nodes in the core instead of doing this manually
> in each driver. So, fix the drivers and documentation, too.
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/a3c35475/attachment.sig>
