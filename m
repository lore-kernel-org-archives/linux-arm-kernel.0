From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 12 Dec 2017 13:32:21 +0100
Subject: [PATCH 03/41] drm/rockchip: support prime import sg table
In-Reply-To: <20170310043305.17216-4-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
 <20170310043305.17216-4-seanpaul@chromium.org>
Message-ID: <2774468.M7lXU1VOoT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 9. M?rz 2017, 23:32:18 CET schrieb Sean Paul:
> From: Haixia Shi <hshi@chromium.org>
> 
> The prime fd to handle ioctl was not used with rockchip before. Support
> was added in order to pass graphics_Gbm and to support potential uses
> within Chrome OS (e.g. zero-copy video decode, camera).
> 
> Signed-off-by: Haixia Shi <hshi@chromium.org>

missing a further Signed-off from Sean Paul as the sender.

I've tested this on the rk3328 together with the wip Lima driver and my wip
Mesa Rockchip Pipe and the kmscube improved from a failure about importing
the buffer to producing actual output, so

Tested-by: Heiko Stuebner <heiko@sntech.de>
