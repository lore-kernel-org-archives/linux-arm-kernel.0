From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Mar 2018 18:27:03 +0100
Subject: [PATCH v5 00/36] DRM Rockchip rk3399 (Kevin)
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Message-ID: <2145089.N3HHEgGPyY@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 9. M?rz 2018, 23:22:51 CET schrieb Enric Balletbo i Serra:
> Hi,
> 
> This patchset includes cleanups, improvements, and bug fixes for
> Rockchip DRM driver and PSR support.
> 
> This new version is the same as before removing some of the patches
> already applied and fixing the Exynos issue due patch '[v4 15/38]
> drm/bridge: analogix_dp: Ensure edp is disabled when shutting down
> the panel' reported by Marek.

The series on both rk3288 (without psr) and rk3399 (with psr)
Tested-by: Heiko Stuebner <heiko@sntech.de>


I've tried reviewing at least the Rockchip parts, so if  bridge-
maintainers are going to apply patches to drm-misc they could
pick up the interlinked Rockchip patches as well.

I don't think it's necessary to wait for the full series to be mergeable
and before I just picked things from the beginning that looked ready
and worked, so I guess continuing this way could help making that
chunk of patches smaller :-) .


Heiko
