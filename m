From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 17 Oct 2016 16:47:44 -0300
Subject: [PATCH] hwrng: meson: Fix module autoload for OF registration
In-Reply-To: <20161017194501.GD8122@obsidianresearch.com>
References: <1476733214-19044-1-git-send-email-javier@osg.samsung.com>
 <20161017194501.GD8122@obsidianresearch.com>
Message-ID: <72b45d57-eabc-6fd8-35cf-5c5262d4f61d@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On 10/17/2016 04:45 PM, Jason Gunthorpe wrote:
> On Mon, Oct 17, 2016 at 04:40:14PM -0300, Javier Martinez Canillas wrote:
> 
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>>  drivers/char/hw_random/meson-rng.c | 1 +
>>  drivers/char/tpm/Kconfig           | 2 +-
> 
> Looks like this patch should not have tpm in it.
>

Argh, yes. I had some unrelated changes in my staging area and did a
commit by mistake. Thanks a lot for pointing out and sorry for that.

I'll post a v2 without this.

> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
