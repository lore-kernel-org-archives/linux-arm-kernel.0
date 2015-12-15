From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 17:57:17 +0100
Subject: [PATCHv2 1/2] ARM: multi_v7_defconfig: Enable Rockchip generic
 power domain.
In-Reply-To: <1450167651-5703-1-git-send-email-enric.balletbo@collabora.com>
References: <1450167651-5703-1-git-send-email-enric.balletbo@collabora.com>
Message-ID: <3507651.2iUrpVaVkB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 09:20:51 Enric Balletbo i Serra wrote:
> In order to meet high performance an low power requirement for Rockchip
> enable the power domain support. The patch also fixes a drm/kms issue,
> driver deferring untils power-domains are available)
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 
> Changes since last version:
> 
>  - Add justification as proposed by Heiko
>  - Add to=arm at kernel.org 
> 

Rebased and applied on top of next/defconfig, thanks!

	Arnd
