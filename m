From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 18:11:18 -0500
Subject: [PATCH] arm64: dts: amd: Fix SPI bus warnings
In-Reply-To: <20180913181245.25484-16-robh@kernel.org>
References: <20180913181245.25484-16-robh@kernel.org>
Message-ID: <CAL_JsqJ8xVaoLh=5sRFwfkdzgeM+S39YDT-QUH9Xw5i3VEL9Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 1:13 PM Rob Herring <robh@kernel.org> wrote:
>
> dtc has new checks for SPI buses. Fix the warnings in node names.
>
> arch/arm64/boot/dts/amd/amd-overdrive.dtb: Warning (spi_bus_bridge): /smb/ssp at e1030000: node name for SPI buses should be 'spi'
> arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dtb: Warning (spi_bus_bridge): /smb/ssp at e1030000: node name for SPI buses should be 'spi'
> arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dtb: Warning (spi_bus_bridge): /smb/ssp at e1030000: node name for SPI buses should be 'spi'
>
> Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but
> will for 4.20.

Ping.

Arnd, Olof, Can you pick this up if the sub-arch maintainer doesn't.

Rob
