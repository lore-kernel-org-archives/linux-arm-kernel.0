From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 11:42:19 +0200
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.20
In-Reply-To: <20181001072003.16238-4-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
 <20181001072003.16238-4-shawnguo@kernel.org>
Message-ID: <CAK8P3a0F6DfVHhh8r7yVCRiZw7BvjVa4siK2B7Rv5DHSnRoicQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2018 at 9:21 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> ----------------------------------------------------------------
> Freescale arm64 device tree update for 4.20:
>  - Add the second Dual UART device for LS208xA SoCs.
>  - Add necessary big-endian property for NOR device on LS104xA based
>    boards, remove unneeded big-endian property from IFC controller.
>  - DTC has new checks for I2C and SPI buses to land into 4.20.  A patch
>    from Rob to fix the bus node names and warnings in unit-addresses.

Pulled into next/dt64, thanks!

      Arnd
