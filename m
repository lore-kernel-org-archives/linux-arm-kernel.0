From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 16 May 2018 19:42:25 +0200
Subject: [PATCH 0/2] ARM: Update multi_v7_defconfig and add add Marvel NAND
In-Reply-To: <20180424081528.25883-1-gregory.clement@bootlin.com> (Gregory
 CLEMENT's message of "Tue, 24 Apr 2018 10:15:26 +0200")
References: <20180424081528.25883-1-gregory.clement@bootlin.com>
Message-ID: <87wow31oqm.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mar., avril 24 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hi,
>
> While adding Marvel NAND controller support in to the
> multi_v7_defconfig, I noticed that this file had greatly diverged, so
> the first patch updates it.
>
> Maybe this first patch should be merged in the current rc to reduce
> the number of merge conflict.
>
> Gregpry
>
> Gregory CLEMENT (2):
>   ARM: multi_v7_defconfig: Update with current configuration
>   ARM: multi_v7_defconfig: Add Marvel NAND controller support

Both applied on mvebu/arm with fixes reported by Thomas.

Gregory

>
>  arch/arm/configs/multi_v7_defconfig | 369 +++++++++++++++---------------------
>  1 file changed, 153 insertions(+), 216 deletions(-)
>
> -- 
> 2.16.3
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
