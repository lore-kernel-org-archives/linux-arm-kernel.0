From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 12:33:06 +0200
Subject: [PATCH] arm64: dts: amd: Fix SPI bus warnings
In-Reply-To: <20180913181245.25484-16-robh@kernel.org>
References: <20180913181245.25484-16-robh@kernel.org>
Message-ID: <CAK8P3a1QeQ-LW2bcSw7mDhZWN6Bo-G-v1sqDMKucgW2sg-mAXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 8:13 PM Rob Herring <robh@kernel.org> wrote:
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

Applied, thanks!

       Arnd
