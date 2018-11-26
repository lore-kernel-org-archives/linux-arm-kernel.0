From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 10:25:58 +0100
Subject: [PATCH 13/13] ARM: dts: rv1108: Pass the 'clock-latency' property
In-Reply-To: <20181125211907.9895-13-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
 <20181125211907.9895-13-otavio@ossystems.com.br>
Message-ID: <4040449.WahONkjxjR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 25. November 2018, 22:19:07 CET schrieb Otavio Salvador:
> Like it is done on cpu nodes of other Rockchip SoCs, pass the
> 'clock-latency' property to the CPU node, so that cpufreq driver
> can take the latency into account when switching frequencies.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

applied for 4.21 after adapting the subject and moving the property
to its correct alphabetical position in the node.


Thanks
Heiko
