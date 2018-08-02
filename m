From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 2 Aug 2018 09:16:46 -0700
Subject: [PATCH] ARM: dts: BCM5301X: Specify flash partitions
In-Reply-To: <20180728121357.13172-1-zajec5@gmail.com>
References: <20180728121357.13172-1-zajec5@gmail.com>
Message-ID: <02fbbfbf-81e7-991f-8e37-99d0b6965971@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/28/2018 05:13 AM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Most devices use Broadcom standard partitions which allows them to be
> described with the "brcm,bcm947xx-cfe-partitions". Exceptions are:
> 1) TP-LINK devices which use "os-image" partition with TRX containing
>    kernel only + separated rootfs partition.
> 2) Asus RT-AC87U with custom "asus" partition.
> 
> This commit also removes undocumented and unsupported linux,part-probe
> binding which got accidentally upstreamed while describing SPI
> controller.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Applied to devicetree/next, thanks!
-- 
Florian
