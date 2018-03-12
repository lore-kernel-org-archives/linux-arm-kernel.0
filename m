From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 12 Mar 2018 11:11:04 +0100
Subject: [PATCH v5 4/4] ARM: rockchip: Set name of regmap_config
In-Reply-To: <20180312095142.30854-5-jeffy.chen@rock-chips.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-5-jeffy.chen@rock-chips.com>
Message-ID: <6419126.t34s1xtZxx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 12. M?rz 2018, 10:51:42 CET schrieb Jeffy Chen:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.17


Thanks
Heiko
