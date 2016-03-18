From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Mar 2016 16:37:55 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318151826.GI19428@n2100.arm.linux.org.uk>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <20160318143059.GD8005@lunn.ch>
 <20160318151826.GI19428@n2100.arm.linux.org.uk>
Message-ID: <20160318163755.0c33d403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Fri, 18 Mar 2016 15:18:26 +0000, Russell King - ARM Linux wrote:

> That's kind of the sticking point for userspace.  As I understand the
> situation, there's been two userspace APIs for crypto - the current
> one, which is network based (af-alg-rr), but performs badly, and
> another (I forget what it's called but it needs kernel patches, but
> is more popular amongst openwrt folk) which I've no experience of.

You have the choice between cryptodev-linux
(http://cryptodev-linux.org/) or OCF-Linux
(http://ocf-linux.sourceforge.net/).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
