From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 18 Mar 2016 08:01:57 -0600
Subject: [PATCH] [media] media: rename media unregister function
In-Reply-To: <2ffc02c944068b2c8655727238d1542f8328385d.1458306276.git.mchehab@osg.samsung.com>
References: <2ffc02c944068b2c8655727238d1542f8328385d.1458306276.git.mchehab@osg.samsung.com>
Message-ID: <56EC0A55.3010803@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2016 07:05 AM, Mauro Carvalho Chehab wrote:
> Now that media_device_unregister() also does a cleanup, rename it
> to media_device_unregister_cleanup().
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

I think adding cleanup is redundant. media_device_unregister()
would imply that there has to be some cleanup releasing resources.
I wouldn't make this change.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
