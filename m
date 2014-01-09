From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 9 Jan 2014 17:43:17 -0300
Subject: [PATCH 06/18] ARM: dts: omap3-overo: Enable MMC2
In-Reply-To: <1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>
 <1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Enric Balletbo to cc]

Hello Florian,

On Thu, Jan 9, 2014 at 1:48 PM, Florian Vaussard
<florian.vaussard@epfl.ch> wrote:
> MMC2 is used by the on-board WiFi module populated on some boards
> (based on Marvell Libertas 8688 SDIO).
>
> Note: currently WiFi only works on cold boot, as the module is not
> properly reset (missing binding for the GPIO reset).
>

Have you looked at commit 0e9fd777 ("ARM: dts: omap3-igep: Add support
for LBEE1USJYC WiFi connected to SDIO") ?

If I remember correctly the LBEE1USJYC Wifi/BT combo module is
basically a Marvell Libertas 8688 Wlan and Enric got soft reset
working too by adding a GPIO property to the regulator for the reset
GPIO.

Hope it helps,
Javier
