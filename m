From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 21 Nov 2012 04:09:13 +0000
Subject: [PATCH 2/2] i2c: s3c2410: Get the i2c bus number from alias id
In-Reply-To: <1353450428-2615-2-git-send-email-dianders@chromium.org>
References: <1353450428-2615-1-git-send-email-dianders@chromium.org>
 <1353450428-2615-2-git-send-email-dianders@chromium.org>
Message-ID: <20121121040913.GA13280@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 02:27:04PM -0800, Doug Anderson wrote:
> From: Padmavathi Venna <padma.v@samsung.com>
> 
> Get the i2c bus number that the device is connected to using the alias
> id.  This makes debugging / grokking of kernel messages much easier.

This doesn't look like a s3c2410 specific change - it's a generic device
tree issue.  This suggests that it sohuld be implemented in the
framework so that all I2C controllers with DT can use it.
