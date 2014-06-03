From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 3 Jun 2014 14:45:49 +0530
Subject: [PATCH 0/2] ARM: dts: dra7: Add crossbar dt support
In-Reply-To: <1401786635-5778-1-git-send-email-r.sricharan@ti.com>
References: <1401786635-5778-1-git-send-email-r.sricharan@ti.com>
Message-ID: <538D9245.2070004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 03 June 2014 02:40 PM, Sricharan R wrote:
> This series introduces DT support for crossbar device and
> changes dra7 peripherals to use crossbar number instead of irq.
>
> This depends on below driver fixes and DMA cleanup series.
Sorry, i meant to say crossbar driver fixes and cleanup series.

Regards,
 Sricharan
> 	http://www.spinics.net/lists/arm-kernel/msg336594.html
>
> R Sricharan (2):
>   ARM: dts: DRA7: Add routable-irqs property for gic node
>   ARM: dts: DRA7: Add crossbar device binding
>
>  arch/arm/boot/dts/dra7.dtsi |  134 ++++++++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 58 deletions(-)
>
