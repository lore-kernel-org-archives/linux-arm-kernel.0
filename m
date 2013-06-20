From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Jun 2013 14:52:53 +0530
Subject: [PATCH 0/2] Fix build breakage for tnetv107x platforms
In-Reply-To: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
References: <1371203869-16308-1-git-send-email-avinashphilipk@gmail.com>
Message-ID: <51C2C9ED.7070409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2013 3:27 PM, Philip Avinash wrote:
> tnetv107x_defconfig build failing on removal selection of NEED_MACH_GPIO_H
> for ARCH_DAVINCI. This is due to header files inclusion from mach/gpio-davinci.h
> So this patch series fixes the build breakage on removal of NEED_MACH_GPIO_H.

So does this mean at the end of 7/7 of your "Convert GPIO Davinci to
platform driver" series, the build is broken?

If yes, then please include them when you repost that series before 7/7.
Having a patch break build is bad.

Thanks,
Sekhar
