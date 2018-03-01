From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Mar 2018 14:34:49 +0100
Subject: [PATCH v5] drm/rockchip: Add device links for master and
 components
In-Reply-To: <20180207175309.21095-1-enric.balletbo@collabora.com>
References: <20180207175309.21095-1-enric.balletbo@collabora.com>
Message-ID: <1621728.R05mi6GW7F@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. Februar 2018, 18:53:09 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Since we are trying to access components' resources in the master's
> suspend/resume PM callbacks(e.g. panel), add device links to correct
> the suspend/resume and shutdown ordering.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next
[after confering on #dri-devel on fixes vs. next]

Thanks
Heiko
