From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 12:33:35 +0200
Subject: [PATCH] arm64: dts: lg: Fix SPI controller node names
In-Reply-To: <20180913181245.25484-20-robh@kernel.org>
References: <20180913181245.25484-20-robh@kernel.org>
Message-ID: <CAK8P3a1JZKwX01VZQUh3OvzUEK8AZVYCDsO0UOrRgjJznWsZbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 8:13 PM Rob Herring <robh@kernel.org> wrote:
>
> SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> name enables dtc SPI bus checks.
>
> Cc: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks!

      Arnd
