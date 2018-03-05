From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 Mar 2018 21:25:30 +0100
Subject: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
In-Reply-To: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
Message-ID: <3380975.Amu1WGHSQ5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 5. M?rz 2018, 13:45:11 CET schrieb Daniel Schultz:
> The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
> Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

applied for 4.17


Thanks
Heiko
