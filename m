From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 18 Aug 2016 18:47:08 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add missing regulators for
 firefly reload board
In-Reply-To: <1471453391-10267-3-git-send-email-ayaka@soulik.info>
References: <19126716.OZv44ZHtAK@diego>
 <1471453391-10267-1-git-send-email-ayaka@soulik.info>
 <1471453391-10267-3-git-send-email-ayaka@soulik.info>
Message-ID: <2277495.ctQ1BYPEEl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 18. August 2016, 01:03:11 schrieb Randy Li:
> There are many regulators are missed in previous commit, this
> commit complete most of them. It also fix some mistakes in the
> regulator properties. The VDD_10(REG10) and VCC_18(REG11) had better
> to keep in always-on state, as it is used as the USB PHY supply,
> corretly we have no way to assign power supply to a USB PHY.
> The VCCA_33(REG8) should be enabled or the GMAC won't work.
> 
> It also fix the wrong properties for audio in io-domains, the supply
> connected to APIO4_VDD is different to firefly release version.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

applied to my dts32 branch for 4.9


Thanks
Heiko
