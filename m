From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 17 Mar 2014 10:30:01 +0530
Subject: [PATCH] ARM: davinci: fix DT booting with default defconfig
In-Reply-To: <1394818228-1846-1-git-send-email-khilman@linaro.org>
References: <1394818228-1846-1-git-send-email-khilman@linaro.org>
Message-ID: <53268151.7030409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 March 2014 11:00 PM, Kevin Hilman wrote:
> Davinci boards tend to have older booloaders without DTB support.
> Enable appended DTB support by default to allow DT booting on older
> platforms.  While there, also enable /proc/device-tree support for
> easy verification of DT boot.
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> Sekhar, this applies on top of your latest defconfig cleanup queued
> for v3.15 and validated with DT and legacy boot on DA850 EVM.

Thanks Kevin. If you will take this directly through ARM-SoC:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
