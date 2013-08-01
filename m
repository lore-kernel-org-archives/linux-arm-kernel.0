From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Aug 2013 17:01:32 +0900
Subject: [PATCH 0/4] ARM: shmobile: ape6evm: support GPIO switches and LEDs
In-Reply-To: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130801080132.GA2157@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:58:59AM +0900, Simon Horman wrote:
> This short series adds support for GPIO swtiches and LEDS to
> the ape6evm board.
> 
> Applies on top of renesas-devel-20130726.
> 
> Simon Horman (4):
>   ARM: shmobile: ape6evm: support GPIO switches
>   ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
>   ARM: shmobile: ape6evm: Add GPIO LEDs
>   ARM: shmobile: ape6evm: Enable gpio-leds in defconfig
> 
>  arch/arm/configs/ape6evm_defconfig     |  6 +++-
>  arch/arm/mach-shmobile/board-ape6evm.c | 60 ++++++++++++++++++++++++++++++++++

Hi Magnus, Hi All,

could I get a review of this, and if appropriate an Ack.
