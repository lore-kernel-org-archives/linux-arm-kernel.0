From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Jan 2015 15:02:02 -0800
Subject: [PATCH v3 1/4] ARM: initial support for Conexant Digicolor
 CX92755 SoC
In-Reply-To: <b78eff5b92f808cb6748097b4f7867fb320e8d21.1421219953.git.baruch@tkos.co.il>
References: <cover.1421219953.git.baruch@tkos.co.il>
 <b78eff5b92f808cb6748097b4f7867fb320e8d21.1421219953.git.baruch@tkos.co.il>
Message-ID: <20150127230202.GB11263@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:40:30AM +0200, Baruch Siach wrote:
> Add initial support for the Conexant CX92755 SoC. The CX92755 is one of the
> Digicolor series of SoCs, all sharing many of the same peripherals. The code
> was tested on the CX92755 evaluation kit, AKA Equinox.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/Kconfig                    |  2 ++
>  arch/arm/mach-digicolor/Kconfig     |  5 +++++
>  arch/arm/mach-digicolor/Makefile    |  1 +
>  arch/arm/mach-digicolor/digicolor.c | 18 ++++++++++++++++++
>  4 files changed, 26 insertions(+)
>  create mode 100644 arch/arm/mach-digicolor/Kconfig
>  create mode 100644 arch/arm/mach-digicolor/Makefile
>  create mode 100644 arch/arm/mach-digicolor/digicolor.c

Applied, thanks.


-Olof
