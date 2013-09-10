From: koen@dominion.thruhere.net (Koen Kooi)
Date: Tue, 10 Sep 2013 21:39:55 +0200
Subject: [PATCH 0/3] ARM: dts: Enable EDMA, MMC and SPI on AM33XX for v3.13
In-Reply-To: <1378841079-15796-1-git-send-email-joelf@ti.com>
References: <1378841079-15796-1-git-send-email-joelf@ti.com>
Message-ID: <5EB8AE91-A996-4CF1-86B7-C8FDEC177E89@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 10 sep. 2013, om 21:24 heeft Joel Fernandes <joelf@ti.com> het volgende geschreven:

> Here are last few patches required to add EDMA and MMC/SPI support for AM33xx.
> 
> Now that all dependent DMA patches and fixes are in linux next or mainline, except
> for [1] which should go in for 3.12 -rc cycle, it is safe to enable MMC and SPI support
> and this patch series enables it. These are originally Matt Porter's patches with
> changes to make it work with recent kernels, addition of irq, memory resources and
> enable other extra properties.
> 
> These patches should cleanly apply on master branch after Koen's patch [2] for basic
> BBB DT support is applied.
> 
> MMC support is enabled for: Beaglebone, AM335x EVM and EVM-SK boards. MMC support
> for BBB is intentionally not added due to custom fixes and other patches that are
> in Koen's tree and which will be separately submitted by him.

Correct, but your patches for MMC support on BBW are missing the card detect entries to make it hotplug work.
