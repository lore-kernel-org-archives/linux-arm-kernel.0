From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 20:50:11 -0600
Subject: [PATCH] ARM: bcm2835: enable CONFIG_LEDS_GPIO
In-Reply-To: <1368758969-26339-1-git-send-email-swarren@wwwdotorg.org>
References: <1368758969-26339-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51959AE3.3020300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 08:49 PM, Stephen Warren wrote:
> Enable CONFIG_LEDS_GPIO and all options required to enable it, or make
> the option useful.
> 
> This patch also regenerated bcm2835_defconfig, which removes two HW_RANDOM
> entries, since they're enabled by default.

I have applied this to bcm2835's for-3.11/defconfig branch.
