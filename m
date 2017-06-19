From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 18:54:29 -0700
Subject: [PATCH] MAINTAINERS: add RV1108 Rockchip soc to maintained files
In-Reply-To: <20170607110627.4678-1-heiko@sntech.de>
References: <20170607110627.4678-1-heiko@sntech.de>
Message-ID: <20170619015429.GA30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 01:06:27PM +0200, Heiko Stuebner wrote:
> The RV1108, as a soc targetted at visual applications, does not follow
> the usual RKxxxx naming scheme and thus falls through the cracks of
> the current file list for Rockchip socs in MAINTAINERS.
> 
> The driver side does not pose a problem, as the rv1108 shares most
> functionality with other Rockchip socs as usual, so we only need to
> add an expression catching the rv1108* arm32 devicetree files.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This could either be applied by arm-soc people directly, or I can
> integrate it into my arm32-dts-branch.

Applied to next/fixes-non-critical


-Olof
