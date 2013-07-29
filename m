From: finn@uni-bremen.de (Finn Hoffmann)
Date: Mon, 29 Jul 2013 19:05:32 +0200
Subject: NSA310 + DT
In-Reply-To: <20130710073706.GA28212@lunn.ch>
References: <20130710073706.GA28212@lunn.ch>
Message-ID: <51F6A0DC.3020501@uni-bremen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have tried to get a current Kernel running on my NSA310. Everything 
works well on Kernels before DT with the mentioned patches from 
https://github.com/peeter123/NSA310-320-debian .
I have linux-3.10.2 running and after I changed the dts file to lm85 
sensors and fanconrtol work but GPIO does not.
I tried https://github.com/lunn/linux/tree/v3.11-rc1-nsa310-tdc and 
linux-3.11.0-rc3.
Both have the problem that r8169 is not working:
r8169: eth0: unknown chipset (mac_version = 0).
and console is spammed with
r8169 0000:01:00.0 eth0: rtl_phyar_cond == 0 (loop: 20, delay: 25).
until I take eth0 down.
GPIO is working.

Any ideas?

Finn
