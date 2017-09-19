From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 19 Sep 2017 19:32:50 +0200
Subject: [PATCH v4 2/4] ARM: dts: exynos: Add clean name of compatible.
In-Reply-To: <1505302915-15699-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1505302915-15699-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170913114215epcas2p30e9a4593bdb6cc3142c6e4dc108ff2f0@epcas2p3.samsung.com>
 <1505302915-15699-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170919173250.o3yhqpxgopxmtlyj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 08:41:53PM +0900, Hoegeun Kwon wrote:
> Exynos 5250 and 5420 have different hardware rotation limits. However,
> currently it uses only one compatible - "exynos5-gsc". Since we have
> to distinguish between these two, we add different compatible.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 

Thanks, applied with modified subject.

Best regards,
Krzysztof
