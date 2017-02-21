From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 21 Feb 2017 23:22:53 +0100
Subject: [PATCH v3 2/3] rtc: armada38x: Add support for Armada 7K/8K
In-Reply-To: <20170220173850.8640-3-gregory.clement@free-electrons.com>
References: <20170220173850.8640-1-gregory.clement@free-electrons.com>
 <20170220173850.8640-3-gregory.clement@free-electrons.com>
Message-ID: <20170221222253.jdcwvcjhey7f4cyv@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/2017 at 18:38:49 +0100, Gregory CLEMENT wrote:
> The Armada 7K/8K use the same RTC IP than the Armada 38x. However the SOC
> integration differs in 2 points:
>  - MBUS bridge timing initialization
>  - IRQ configuration at SoC level
> 
> Moreover the Armada 7K/8K have an issue preventing to get the interrupt
> from alarm 1. This commit allows to use alarm 2 for these A7K/8K but to
> still use alarm 1 for the Armada 38x.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/rtc/armada-380-rtc.txt     |  8 ++-
>  drivers/rtc/rtc-armada38x.c                        | 65 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
