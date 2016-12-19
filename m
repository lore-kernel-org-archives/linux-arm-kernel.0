From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 18 Dec 2016 18:08:01 -0800
Subject: [PATCH] ARM: ep93xx: Disable TS-72xx watchdog before uncompressing
In-Reply-To: <20161211191615.13696-1-f.fainelli@gmail.com>
References: <20161211191615.13696-1-f.fainelli@gmail.com>
Message-ID: <6d58631d-37a2-8362-e9aa-0c360fac4509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/11/16 ? 11:16, Florian Fainelli a ?crit :
> The TS-72xx/73xx boards have a CPLD watchdog which is configured to
> reset the board after 8 seconds, if the kernel is large enough that this
> takes about this time to decompress the kernel, we will encounter a
> spurious reboot.
> 
> Do not pull ts72xx.h, but instead locally define what we need to disable
> the watchdog.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Hartley, Ryan, do you guys maintain a git tree with EP93xx patches, or
should I submit them through RMK's patch system once you are okay with them?

Thanks!
-- 
Florian
