From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Jul 2018 07:33:20 +0100
Subject: [PATCH 2/3] arm/arm64: configs: Remove the MFD_ prefix for
 MFD_CROS_EC_I2C/SPI symbols.
In-Reply-To: <20180702230226.GA86110@decatoncale.mtv.corp.google.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-3-enric.balletbo@collabora.com>
 <CAJKOXPd51yU8-zObXszc4zJpHsGtMNFTsbQsQdKBFg=k22xZLA@mail.gmail.com>
 <20180702230226.GA86110@decatoncale.mtv.corp.google.com>
Message-ID: <20180703063320.GD4242@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Jul 2018, Benson Leung wrote:
> On Mon, Jul 02, 2018 at 01:05:40PM +0200, Krzysztof Kozlowski wrote:
> > On 2 July 2018 at 12:22, Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > > The cros-ec I2C and SPI transport drivers have been moved from MFD
> > > subsystem to platform/chrome, at the same time, the config symbol has
> > > been renamed and lost the MFD_ prefix, so update all configs to the new
> > > config symbol name.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > >  arch/arm/configs/exynos_defconfig   | 4 ++--
> > >  arch/arm/configs/multi_v7_defconfig | 4 ++--
> > >  arch/arm/configs/pxa_defconfig      | 4 ++--
> > >  arch/arm64/configs/defconfig        | 4 ++--
> > >  4 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > Since you put in one patch multiple defconfigs belonging to multiple
> > maintainers, I assume you are pushing this through arm-soc or Russell.
> > In such case, for Exynos boards:
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > Best regards,
> > Krzysztof
> 
> I was planning on creating an immutable branch for this series and merging it
> through platform/chrome.
> 
> Lee, Russell, Dmitry, what do you think?

Fine by me.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
