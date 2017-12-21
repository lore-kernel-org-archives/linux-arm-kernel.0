From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Dec 2017 06:58:17 -0800
Subject: [PATCH 0/2] ARM: dts: Some am43x fixes
In-Reply-To: <20171215171643.8345-1-d-gerlach@ti.com>
References: <20171215171643.8345-1-d-gerlach@ti.com>
Message-ID: <20171221145817.GO3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [171215 09:19]:
> Hi,
> This series has two fixes for am43x based platforms. First patch disables OPP50
> on am437x-idk-evm which the board supply does not support. Second patch is for
> am43x-epos-evm and adds dcdc2 regulator as the missing cpu0-supply which
> enables CPUFreq on this platform.

Applying both into omap-for-v4.16/dt thanks.

Tony
