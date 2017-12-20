From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Wed, 20 Dec 2017 13:15:09 +0000
Subject: [PATCH v2 3/8] media: v4l2-async: simplify v4l2_async_subdev
 structure
In-Reply-To: <9702fbf0c9dd2f6a657aff0c7fff3ca849d76713.1513682135.git.mchehab@s-opensource.com>
References: <cover.1513682135.git.mchehab@s-opensource.com>
 <9702fbf0c9dd2f6a657aff0c7fff3ca849d76713.1513682135.git.mchehab@s-opensource.com>
Message-ID: <CA+V-a8vCNs7WgW57oDW4oqinYnb6etMtOTi4M1N+cHv4uFR2ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Thanks for the patch.

On Tue, Dec 19, 2017 at 11:18 AM, Mauro Carvalho Chehab
<mchehab@s-opensource.com> wrote:
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
> Acked-by: Benoit Parrot <bparrot@ti.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  drivers/media/platform/am437x/am437x-vpfe.c    |  6 +++---

For above:

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad
