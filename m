From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Dec 2016 17:47:00 +0100
Subject: [PATCH] ARM: at91/dt: sama5d2: add ssc0 definition
In-Reply-To: <CAJP5LRNHDXQtZDRcQcNuS76uvUndKVjKqWC2KXTM+DOMrro5kg@mail.gmail.com>
References: <CAJP5LRNHDXQtZDRcQcNuS76uvUndKVjKqWC2KXTM+DOMrro5kg@mail.gmail.com>
Message-ID: <20161212164700.vepf4rct5gjwcvzx@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 at 12:28:34 +0200, Alex Gershgorin wrote :
> 

> From 3a5a8e78ccccab2858c5944000884ab3c49eba5a Mon Sep 17 00:00:00 2001
> From: Alex <Alex.Gershgorin@qcore.com>
> Date: Sun, 4 Dec 2016 16:03:56 +0200
> Subject: [PATCH] ARM: at91/dt: sama5d2: add ssc0 definition
> 
> The sama5d2 SoC has Synchronous Serial Controller which provides
> synchronous communication link with external devices.
> It's generally used in audio and telecom applications such as
> I2S, Short Frame Sync, Long Frame Sync.
> 
> Signed-off-by: Alex Gershgorin <alex.gershgorin@qcore.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
