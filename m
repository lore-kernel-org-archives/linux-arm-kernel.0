From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 02 Nov 2014 13:27:44 +0100
Subject: [PATCH] ARM: dts: rockchip: add serial aliases for rk3066 and
 rk3188
In-Reply-To: <1414684277-17248-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1414684277-17248-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <1556322.3CdNOEchaI@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. Oktober 2014, 16:51:17 schrieb Julien CHAUVEAU:
> Add aliases for UARTs on rk3066 and rk3188 in order to fix the numbering
> scheme. This will keep the debug console on ttyS2 when UART 1 is disabled,
> for example.
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

applied to my dts branch for 3.19
