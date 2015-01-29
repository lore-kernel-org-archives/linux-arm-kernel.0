From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 29 Jan 2015 07:16:47 +0100
Subject: [PATCH 06/16] ARM: cns3xxx: convert PCI to use generic config
 accesses
In-Reply-To: <1420857290-8373-7-git-send-email-robh@kernel.org> (Rob Herring's
 message of "Fri, 9 Jan 2015 20:34:40 -0600")
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
 <1420857290-8373-7-git-send-email-robh@kernel.org>
Message-ID: <m37fw6xga8.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> Convert the cns3xxx PCI driver to use the generic config access functions.
>
> This changes accesses from __raw_readl/__raw_writel to readl/writel.
>
>  arch/arm/mach-cns3xxx/pcie.c | 52 +++++++++-----------------------------------

This looks fine:
Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
