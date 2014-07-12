From: xjq@rock-chips.com (Jianqun)
Date: Sat, 12 Jul 2014 08:59:21 +0800
Subject: [PATCH] ASoC: rockchips: fix build error
In-Reply-To: <20140711134848.GX30458@sirena.org.uk>
References: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
 <20140711134848.GX30458@sirena.org.uk>
Message-ID: <53C08869.5060408@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?07?11? 21:48, Mark Brown wrote:
> On Fri, Jul 11, 2014 at 03:07:08PM +0200, Arnd Bergmann wrote:
>> The newly added rockchip_i2s driver is lacking an include of
>> linux/module.h, causing a build error in some cases:
> 
> A fix for this has already been applied.
> 
Thank you very much :), it's great help for a begainner.

-- 
-------------
? ? ? Jay
Rockchip Electronics Co.Ltd
****************************************************************************
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED.
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
****************************************************************************
