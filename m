From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Aug 2012 17:20:12 +0000 (UTC)
Subject: [PATCH] ARM: AM33XX: clock: Add dcan clock aliases for device-tree
In-Reply-To: <1346061842-28714-1-git-send-email-hvaibhav@ti.com>
References: <1346061842-28714-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1208271717420.26953@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 27 Aug 2012, Vaibhav Hiremath wrote:

> Currently, the device names for the dcan module follows the
> format "dcan.X", where 'X' is the dcan instance number.
> On other side, driver may request for clock with/without con_id
> and dev_id, and it is expected that platform should respect this
> request and return the requested clock handle.
> 
> Now, when using device tree, the format of the device name created
> by OF layer is different, "<reg-address>.<device-name>",
> assuming that the device-tree "reg" property is specified.
> This causes the look-up failure for clock node in dcan driver
> 
> To fix this add new dcan clock alias for using device-tree.

Is the dcan driver present in v3.6-rc kernels?  Doesn't look like it but 
maybe it's under an alias.


- Paul
