From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 23 Jan 2017 17:26:24 +0100
Subject: [PATCH v4 6/9] clocksource/drivers/rockchip_timer: split
 bc_timer into rk_timer and rk_clock_event_device
In-Reply-To: <1480436092-10728-7-git-send-email-al.kochet@gmail.com>
References: <1480343486-25539-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-1-git-send-email-al.kochet@gmail.com>
 <1480436092-10728-7-git-send-email-al.kochet@gmail.com>
Message-ID: <20170123162624.GG2166@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 07:14:49PM +0300, Alexander Kochetkov wrote:
> The patch move ce field out of struct bc_timer into struct
> rk_clock_event_device and rename struct bc_timer to struct rk_timer.

Why ?
