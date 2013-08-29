From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Aug 2013 19:28:32 +0800
Subject: [PATCH 1/3] ARM: dts: imx6qdl-wandboard: Add usbotg support
In-Reply-To: <1377091624-13174-1-git-send-email-festevam@gmail.com>
References: <1377091624-13174-1-git-send-email-festevam@gmail.com>
Message-ID: <20130829112829.GD18729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 10:27:02AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Tested via g_ether:
> 
> $ modprobe g_ether
> using random self ethernet address
> using random host ethernet address
> usb0: HOST MAC 42:b5:26:a9:48:21
> usb0: MAC 36:a6:85:9b:9e:13
> using random self ethernet address
> using random host ethernet address
> g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
> g_ether gadget: g_ether ready
> $ g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
> $ ifconfig usb0 10.0.0.2
> 
> Then on the PC host side:
> 
> ~$ sudo ifconfig usb0 10.0.0.1
> ~$ ping 10.0.0.2
> PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
> 64 bytes from 10.0.0.2: icmp_req=1 ttl=64 time=1.26 ms
> 64 bytes from 10.0.0.2: icmp_req=2 ttl=64 time=0.280 ms
> 64 bytes from 10.0.0.2: icmp_req=3 ttl=64 time=0.297 ms
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied all 3, thanks.

Shawn
