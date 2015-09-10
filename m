From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 10 Sep 2015 20:33:32 +0200
Subject: [PATCH 2/2] [media] media-device: split media initialization and
 registration
In-Reply-To: <55F1C04C.1040906@linux.intel.com>
References: <1441890195-11650-1-git-send-email-javier@osg.samsung.com>
 <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
 <55F1C04C.1040906@linux.intel.com>
Message-ID: <55F1CCFC.4080604@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sakari,

On 09/10/2015 07:39 PM, Sakari Ailus wrote:
> Javier Martinez Canillas wrote:
>> Also, add a media_entity_cleanup() function that will destroy the
>> graph_mutex that is initialized in media_entity_init().
> 
> media_device_init() and media_device_cleanup()?
>

Right, sorry about that. I'll fix it.

Thanks!
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
