From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 28 Jun 2017 17:45:03 +0200
Subject: [PATCH 3/3] arm64: dts: rockchip: set rk3399 dynamic CPU power
 coefficients
In-Reply-To: <20170623170737.46265-3-briannorris@chromium.org>
References: <20170623170737.46265-1-briannorris@chromium.org>
 <20170623170737.46265-3-briannorris@chromium.org>
Message-ID: <3456973.xqkASENUTq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Juni 2017, 10:07:37 CEST schrieb Brian Norris:
> Provide the dynamic power coefficient of the big and little CPU
> clusters. These numbers are currently in use on the Samsung Chromebook
> Plus ("Kevin").
> 
> The power allocator thermal governor doesn't know how to do anything if
> it doesn't get power parameters from its cooling devices (in this case,
> CPUfreq). So this effectively enables the power-allocator governor.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied for 4.14 after extending the property to all cpu cores.


Thanks
Heiko
