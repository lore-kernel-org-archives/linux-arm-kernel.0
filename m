From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Aug 2012 16:42:14 +0100
Subject: [PATCH] driver: misc: bmp085: remove "of_match_table" property.
In-Reply-To: <20120806093033.GH17551@arwen.pp.htv.fi>
References: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
 <20120806093033.GH17551@arwen.pp.htv.fi>
Message-ID: <20120806154214.GC29272@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 12:30:34PM +0300, Felipe Balbi wrote:
> On Mon, Aug 06, 2012 at 02:58:44PM +0530, Sourav Poddar wrote:
> > There is an automatic binding done for I2C devices in the of_i2c core
> > code. So, DT will be able to bind to any I2C device using the
> > already existing table: MODULE_DEVICE_TABLE(i2c, bmp085_id).

> Acked-by: Felipe Balbi <balbi@ti.com>

It's good practice to have an explict compatible string even if the
default happens to work in order to avoid any name clashes.
