From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 8 Dec 2011 14:41:24 -0800
Subject: [PATCH v2] Documentation/pinctrl: various minor fixes
In-Reply-To: <1323383765-30742-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <74CDBE0F657A3D45AFBB94109FB122FF1750B77B9F@HQMAIL01.nvidia.com>
 <1323383765-30742-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B77BB0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote at Thursday, December 08, 2011 3:36 PM:
> - add some consts
> - don't use the group index alone to determine the value to write to
>   foo's mux register. For spi and i2c the group index is always 0.
>   Additionally using the function index makes much more sense as it
>   generates a different value for each function/group pair.
> - fix a few syntax errors
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
