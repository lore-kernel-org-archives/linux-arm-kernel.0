From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 26 Jan 2015 02:22:55 +0100
Subject: [PATCH v4 0/3] add support for Firefly-RK3288 and Rayeager PX2
 boards
In-Reply-To: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
References: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
Message-ID: <2137926.nqOiED5bzz@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 25. Januar 2015, 21:39:33 schrieb FUKAUMI Naoki:
> This series adds support for following Rockchip SoC based boards.
> 
>  - Firefly, Firefly-RK3288 (both beta and mass production version)
>  - ChipSPARK, Rayeager PX2

I've applied this series with Andy's Tested-by for the Rayeager board and my 
Tested-by for the Firefly.

One caveat, I had to remove the gmac node from the firefly dtsi, as the whole 
gmac series goes through the network tree, so the dtb won't compile either in 
my tree or arm-soc due to the missing core node.

I'll try to see if I can get the separate gmac node in when everything is 
combined in 3.20-rc1.


Heiko
