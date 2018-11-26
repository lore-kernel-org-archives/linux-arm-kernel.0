From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 14:16:23 +0100
Subject: [PATCH 09/10] ARM64: dts: rockchip: Add all CPUs in cooling maps
In-Reply-To: <ee0bd5fb56652141e5ce23927b258b1779844af6.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <ee0bd5fb56652141e5ce23927b258b1779844af6.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <3451054.D49JNUWnuL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. November 2018, 11:04:32 CET schrieb Viresh Kumar:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

looks like I forgot to respond ... applied like 7 days ago
and already part of my pull-request for 4.21


Thanks
Heiko
