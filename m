From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 Aug 2017 18:11:53 -0700
Subject: [GIT PULL 1/2] bcm2835-dt-next-2017-08-15
In-Reply-To: <20170815180325.12809-1-eric@anholt.net>
References: <20170815180325.12809-1-eric@anholt.net>
Message-ID: <0385a287-7cdc-296e-2595-2fe03372f7e6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/15/2017 11:03 AM, Eric Anholt wrote:
> The following changes since commit ad41eacc11046fe6a199cffb6663bcd9c90df2f8:
> 
>   Merge tag 'bcm2835-dt-next-2017-08-07' into devicetree/next (2017-08-07 10:45:35 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2017-08-15
> 
> for you to fetch changes up to f29c256853b7412961d3ee80ca525bd2530573db:
> 
>   ARM: dts: bcm283x: Add 32-bit enable method for SMP (2017-08-14 20:09:44 +0200)
> 
> ----------------------------------------------------------------
> This pull request brings in a new SMP enable-method compat string,
> which is needed to move the 32-bit SMP boot code out of the irqchip.
> 
> ----------------------------------------------------------------
> Stefan Wahren (2):
>       dt-bindings: arm: add SMP enable-method for BCM2836
>       ARM: dts: bcm283x: Add 32-bit enable method for SMP

Merged, thanks Eric!
-- 
Florian
