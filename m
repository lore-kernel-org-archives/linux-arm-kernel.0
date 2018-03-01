From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Mar 2018 14:33:37 +0100
Subject: [PATCH] drm/rockchip: vop: Init vskiplines in scl_vop_cal_scale()
In-Reply-To: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
References: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
Message-ID: <126662348.ZcAOZAFD3X@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Februar 2018, 07:22:50 CET schrieb Jeffy Chen:
> Currently we are calling scl_vop_cal_scale() to get vskiplines for yrgb
> and cbcr. So the cbcr's vskiplines might be an unexpected value if the
> second scl_vop_cal_scale() didn't update it.
> 
> Init vskiplines in scl_vop_cal_scale() to avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied to drm-misc-next with Sean Paul's Ack


Heiko
