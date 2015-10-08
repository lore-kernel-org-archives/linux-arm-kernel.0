From: edward.cragg@codethink.co.uk (Edward Cragg)
Date: Thu, 8 Oct 2015 17:56:42 +0100
Subject: [PATCH v2 3/4] ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ
 boards
In-Reply-To: <1444249865-6897-4-git-send-email-carlo@caione.org>
References: <1444249865-6897-1-git-send-email-carlo@caione.org>
 <1444249865-6897-4-git-send-email-carlo@caione.org>
Message-ID: <20151008165641.GD5258@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 10:31:04PM +0200, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
Tested-by: Edward Cragg <edward.cragg@codethink.co.uk>

> ---
>  arch/arm/boot/dts/Makefile             |   3 +
>  arch/arm/boot/dts/meson8b-mxq.dts      |  67 ++++++++++++
>  arch/arm/boot/dts/meson8b-odroidc1.dts |  67 ++++++++++++
>  arch/arm/boot/dts/meson8b.dtsi         | 186 +++++++++++++++++++++++++++++++++
>  4 files changed, 323 insertions(+)
>  create mode 100644 arch/arm/boot/dts/meson8b-mxq.dts
>  create mode 100644 arch/arm/boot/dts/meson8b-odroidc1.dts
>  create mode 100644 arch/arm/boot/dts/meson8b.dtsi
> 
