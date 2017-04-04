From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 4 Apr 2017 20:38:17 +0300
Subject: [PATCH v4 0/8] mfd: Add OF device table to I2C drivers that are
 missing it
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Message-ID: <20170404173817.gizxme3fgd6nwzbp@raspberrypi-3.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 04, 2017 at 11:30:28AM -0400, Javier Martinez Canillas wrote:
> This series add OF device ID tables to mfd I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.

For patches 1-5 you can add:

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
