From: a.zummo@towertech.it (Alessandro Zummo)
Date: Fri, 25 Nov 2011 19:42:21 +0100
Subject: [V1 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <201111251719.39636.arnd@arndb.de>
References: <1322219217-1866-1-git-send-email-jtzhou@marvell.com>
 <201111251505.29823.arnd@arndb.de>
 <CAN1soZzfN2aNNH5Hmuv79Y-u-GR2Mnfh3oR2D2QWZNFV6-N+YQ@mail.gmail.com>
 <201111251719.39636.arnd@arndb.de>
Message-ID: <20111125194221.66869a6f@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Nov 2011 17:19:38 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> I could do that with an Ack from Alessandro, but normally it should
> go through his tree. I guess it should also go through the rtc-linux
> mailing list, though I don't know how active that is.

 Hi,

  I keep any eye on the list but the patches can go thru their specific
 subsystem tree. Given that the RTC are closely coupled with a specific board/arch,
 it makes no sense to handle them differently.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
