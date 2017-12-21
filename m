From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 20 Dec 2017 17:35:21 -0800
Subject: [GIT PULL 2/2] bcm2835-drivers-next-2017-12-19
In-Reply-To: <20171220004257.16764-2-eric@anholt.net>
References: <20171220004257.16764-1-eric@anholt.net>
 <20171220004257.16764-2-eric@anholt.net>
Message-ID: <a44d9d7d-4256-31a3-7b84-6ff5c5102150@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/19/17 ? 16:42, Eric Anholt a ?crit?:
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> 
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2017-12-19
> 
> for you to fetch changes up to 9107ee6a50b81180f29a9f6588b21917dde2abdd:
> 
>   firmware: raspberrypi: print time using time64_t (2017-11-28 16:24:33 -0800)
> 
> ----------------------------------------------------------------
> This pull request brings in a (cosmetic) y2038 fix for the Raspberry
> Pi firmware driver.
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       firmware: raspberrypi: print time using time64_t

Merged, thanks Eric!
-- 
Florian
