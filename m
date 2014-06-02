From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 02 Jun 2014 18:24:17 +0200
Subject: [PATCH 1/3] arm: multi_v7: enable igb, stmpe, spidev, lm95245,
 pwm leds
In-Reply-To: <538C9F83.1010800@wwwdotorg.org>
References: <cc612cd3f24f01cfc8fd3e81b1027ff94862e8b4.1401700579.git.marcel@ziswiler.com>
 <538C9F83.1010800@wwwdotorg.org>
Message-ID: <538CA531.2090006@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 06:00 PM, Stephen Warren wrote:
>> BTW: How about TEGRA_EMC_SCALING_ENABLE
>
> I thought a patch was sent to remove that. Perhaps the patch was only
> sent to tegra_defconfig.
>
>> ... MTD_M25P80 which depends on MTD_SPI_NOR
>
> I've seen patches to fix that too.

Yes, you are right. I have seen patches as well but none of them made it 
yet I guess.
