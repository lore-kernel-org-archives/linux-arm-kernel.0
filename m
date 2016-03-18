From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 18 Mar 2016 10:48:13 -0300
Subject: [PATCH] [media] media: rename media unregister function
In-Reply-To: <2ffc02c944068b2c8655727238d1542f8328385d.1458306276.git.mchehab@osg.samsung.com>
References: <2ffc02c944068b2c8655727238d1542f8328385d.1458306276.git.mchehab@osg.samsung.com>
Message-ID: <56EC071D.5060400@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mauro,

On 03/18/2016 10:05 AM, Mauro Carvalho Chehab wrote:
> Now that media_device_unregister() also does a cleanup, rename it
> to media_device_unregister_cleanup().
>

I believe there should be a Suggested-by Sakari Ailus tag here.
 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

The patch looks good and I agree that makes things more clear.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
