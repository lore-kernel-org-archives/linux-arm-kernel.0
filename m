From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 16 Jul 2015 14:22:25 +0200
Subject: [PATCH] ARM: dts: rockchip: add missing device_type = "memory" to
 boards
In-Reply-To: <1521614.R7mMBQe0OX@diego>
References: <1521614.R7mMBQe0OX@diego>
Message-ID: <3631471.OSGgxp8WLq@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. Juli 2015, 23:21:05 schrieb Heiko St?bner:
> The memory node is supposed to contain a device_type property marking
> it as memory. The currently included boards miss this property.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied to my dts branch for 4.3
