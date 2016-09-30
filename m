From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 30 Sep 2016 12:00:04 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable BCM47xx/BCM5301x drivers
In-Reply-To: <1472339552-9960-1-git-send-email-f.fainelli@gmail.com>
References: <1472339552-9960-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <2a25e754-6327-b8b2-32f9-07050a24ca63@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2016 04:12 PM, Florian Fainelli wrote:
> Add a bunch of required drivers and subsystems:
> 
> - BCMA is the on-chip discoverable bus which registers a bunch of
>   peripherals
> - Enable the BCM47xx watchdog driver to get working system reboot
> - Enable the BCM47xx NVRAM/SPROM drivers to be able to fetch MAC
>   addresses and other variables needed for system operation
> - Make BGMAC (built-in Ethernet adapter) a module
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to defconfig/next.
-- 
Florian
