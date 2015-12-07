From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Dec 2015 18:06:07 +0100
Subject: [PATCH 0/5] multi and mvebu v5 defconfig updates
In-Reply-To: <1449012812-9779-1-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Wed, 2 Dec 2015 00:33:27 +0100")
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
Message-ID: <87610achog.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd
 
 On mer., d?c. 02 2015, Andrew Lunn <andrew@lunn.ch> wrote:

> This patchset updates both multi_v5_defconfig and mvebu_v5_defconfig.
> It adds support for Orion5x, now that it is multi-arch, and adds back
> DSA and its drivers, which now depends on switchdev.
>
> Andrew Lunn (5):
>   ARM: config: Regenerate multi_v5_defconfig
>   ARM: config: Reenable DSA in multi_v5_defconfig
>   ARM: config: Add orion5x to multi_v5_defconfig

>   ARM: mvebu: Reenable DSA in mvebu_v5_defconfig
>   ARM: mvebu: update v5 defconfig for Orion5x machines

To be sure there won't be a leftover, I applied the last 2 patches, but
not the 3 first ones, as for my understanding it is better that it is
managed by arm-soc directly.

Gregory

>
>  arch/arm/configs/multi_v5_defconfig | 43 +++++++++++++++++++++++++++----------
>  arch/arm/configs/mvebu_v5_defconfig | 31 +++++++++++++++++++++++++-
>  2 files changed, 62 insertions(+), 12 deletions(-)
>
> -- 
> 2.6.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
