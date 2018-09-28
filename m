From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 12:34:07 +0200
Subject: [PATCH] ARM: dts: lpc32xx: Fix SPI controller node names
In-Reply-To: <20180913181245.25484-9-robh@kernel.org>
References: <20180913181245.25484-9-robh@kernel.org>
Message-ID: <CAK8P3a2i2mpOLSK+nk8+gjeSNuzyH4Q8YG_MbW5jSS_ydBh5Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 8:12 PM Rob Herring <robh@kernel.org> wrote:
>
> SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> name enables dtc SPI bus checks.
>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!

      Arnd
