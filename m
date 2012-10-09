From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 9 Oct 2012 10:35:23 +0000
Subject: [PATCH] Add McSPI devices found in AM33xx SoC to dtsi
In-Reply-To: <CAAek22HhtFc-1XOFrQC8DKZ9VdKyuShE_G_j4581WL15JTNJXg@mail.gmail.com>
References: <CAAek22HhtFc-1XOFrQC8DKZ9VdKyuShE_G_j4581WL15JTNJXg@mail.gmail.com>
Message-ID: <518397C60809E147AF5323E0420B992E3E9CA61C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 10:40:58, Phil Pokorny wrote:
> We're using the BeagleBone for a project and we need the SPI devices
> available and configured with all available chip selects.
> 
> Please accept the following patch to add these to the base .dtsi file
> so they can then be enabled in the beaglebone specific .dts with
> minimal fuss.

Patch for adding MCSPI in am33xx.dtsi already been sent by me.
https://lkml.org/lkml/2012/9/18/32

Thanks
Avinash

> 
