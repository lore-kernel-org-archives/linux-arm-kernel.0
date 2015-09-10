From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Thu, 10 Sep 2015 20:39:24 +0300
Subject: [PATCH 2/2] [media] media-device: split media initialization and
 registration
In-Reply-To: <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
References: <1441890195-11650-1-git-send-email-javier@osg.samsung.com>
 <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
Message-ID: <55F1C04C.1040906@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> Also, add a media_entity_cleanup() function that will destroy the
> graph_mutex that is initialized in media_entity_init().

media_device_init() and media_device_cleanup()?

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
