From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 18:11:48 -0500
Subject: [PATCH] arm64: dts: lg: Fix SPI controller node names
In-Reply-To: <20180913181245.25484-20-robh@kernel.org>
References: <20180913181245.25484-20-robh@kernel.org>
Message-ID: <CAL_JsqLjA6MBWKnchY0YYQYDRcPTHmTvvepwhXi5-BE9xBvjHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 1:13 PM Rob Herring <robh@kernel.org> wrote:
>
> SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
> name enables dtc SPI bus checks.
>
> Cc: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but
> will for 4.20.

Ping.

Arnd, Olof, Can you pick this up if the sub-arch maintainer doesn't.

Rob
