From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 25 Apr 2018 14:04:07 +0200
Subject: [RFC 09/10] usb: host: exynos: Remove support for Exynos5440
In-Reply-To: <20180424203239.21885-10-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-10-krzk@kernel.org>
Message-ID: <20180425120407.GA6582@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:32:38PM +0200, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/usb/host/ehci-exynos.c | 7 -------
>  drivers/usb/host/ohci-exynos.c | 6 ------
>  2 files changed, 13 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
