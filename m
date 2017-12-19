From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Tue, 19 Dec 2017 10:27:17 +0200
Subject: [PATCH 3/8] media: v4l2-async: simplify v4l2_async_subdev
 structure
In-Reply-To: <014b64d13c8b9d516afc3319a9de1a97b2a845de.1513625884.git.mchehab@s-opensource.com>
References: <cover.1513625884.git.mchehab@s-opensource.com>
 <014b64d13c8b9d516afc3319a9de1a97b2a845de.1513625884.git.mchehab@s-opensource.com>
Message-ID: <20171219082717.3cs62f2lqaj4ib27@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 05:53:57PM -0200, Mauro Carvalho Chehab wrote:
> The V4L2_ASYNC_MATCH_FWNODE match criteria requires just one
> struct to be filled (struct fwnode_handle). The V4L2_ASYNC_MATCH_DEVNAME
> match criteria requires just a device name.
> 
> So, it doesn't make sense to enclose those into structs,
> as the criteria can go directly into the union.
> 
> That makes easier to document it, as we don't need to document
> weird senseless structs.
> 
> At drivers, this makes even clearer about the match criteria.
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

I'm not sure this is needed but it doesn't break anything either.

Feel free to add:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
