From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 1 Apr 2016 10:58:54 -0600
Subject: [PATCH 1/4] ARM: bcm2835: Switch BCM2835 to sdhci-iproc.c for MMC
In-Reply-To: <1459470643-9070-1-git-send-email-eric@anholt.net>
References: <1459470643-9070-1-git-send-email-eric@anholt.net>
Message-ID: <56FEA8CE.4090700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 06:30 PM, Eric Anholt wrote:
> This approximately triples write performance for the SD card.  My card
> is too full of important data to collect very reliable numbers, but I
> see 271.361% +/- 166.742% improvement (n=3 before, 6 after), for 'dd
> if=/dev/zero of=/boot/asdf bs=1M count=3 oflag=dsync,direct'.  Read
> performance appears to be unaffected.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
