From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Jun 2017 12:37:22 -0700
Subject: [GIT PULL 1/4] bcm2835-defconfig-next-2017-06-12
In-Reply-To: <20170613174356.22426-1-eric@anholt.net>
References: <20170613174356.22426-1-eric@anholt.net>
Message-ID: <c9488391-18ae-5d4e-9e7b-b73aec0ed7d5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2017 10:43 AM, Eric Anholt wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-defconfig-next-2017-06-12
> 
> for you to fetch changes up to 3e9aaaf1d814586404dc93461ec955dd90dc8934:
> 
>   ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support (2017-06-12 14:07:38 -0700)
> 
> ----------------------------------------------------------------
> This pull request enables USB OTG mode in the Pi 0/1 defconfig.
> 
> ----------------------------------------------------------------
> Stefan Wahren (1):
>       ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support

Merged, thanks Eric!

> 
>  arch/arm/configs/bcm2835_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 


-- 
Florian
