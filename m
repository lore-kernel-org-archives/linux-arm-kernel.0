From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Fri, 29 Dec 2017 11:43:38 +0200
Subject: [PATCH 2/2] media: don't include drivers/media/i2c at cflags
In-Reply-To: <ada795551aff6662d2322f63e55a853a58389eb5.1514488526.git.mchehab@s-opensource.com>
References: <fada1935590f66dc6784981e0d557ca09013c847.1514488526.git.mchehab@s-opensource.com>
 <ada795551aff6662d2322f63e55a853a58389eb5.1514488526.git.mchehab@s-opensource.com>
Message-ID: <20171229094338.rgcetcop33wflxre@kekkonen.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 02:21:49PM -0500, Mauro Carvalho Chehab wrote:
> Most of the I2C headers got moved a long time ago to
> include/media/i2c. Stop including them at the patch.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
