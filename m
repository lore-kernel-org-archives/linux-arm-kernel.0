From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 18:12:35 -0500
Subject: [PATCH] ARM: dts: lpc32xx: Fix SPI controller node names
In-Reply-To: <20180913181245.25484-9-robh@kernel.org>
References: <20180913181245.25484-9-robh@kernel.org>
Message-ID: <CAL_JsqLHXWFmPk0m_RS-mj85VGx5y85s_mcGscTfQjw_nFZXzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 1:12 PM Rob Herring <robh@kernel.org> wrote:
>
> SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> name enables dtc SPI bus checks.
>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Ping.

Arnd, Olof, Can you pick this up if the sub-arch maintainer doesn't.

Rob
