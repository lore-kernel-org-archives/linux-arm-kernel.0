From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 27 Aug 2018 19:42:49 +0200 (CEST)
Subject: [PATCH 2/2] ARM: dts: add Raspberry Pi Compute Module 3 and IO
 board
In-Reply-To: <1533381003-13367-3-git-send-email-stefan.wahren@i2se.com>
References: <1533381003-13367-1-git-send-email-stefan.wahren@i2se.com>
 <1533381003-13367-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1901621884.322332.1535391770006@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 4. August 2018 um 13:10 geschrieben:
>  
> 
> The Raspberry Pi Compute Module 3 (CM3) and the Raspberry Pi
> Compute Module 3 Lite (CM3L) are SoMs which contains a BCM2837 processor,
> 1 GB RAM and a GPIO expander. The CM3 has a 4 GB eMMC, but on the CM3L
> the eMMC is unpopulated and it's up to the user to connect their
> own SD/MMC device. The dtsi file is designed to work for both modules.
> There is also a matching carrier board which is called
> Compute Module IO Board V3.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          | 87 ++++++++++++++++++++++
>  arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             | 52 +++++++++++++
>  arch/arm64/boot/dts/broadcom/Makefile              |  3 +-
>  .../boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts      |  2 +

oops, i mixed arm and arm64 within this patch. I will send a new version.

Stefan
