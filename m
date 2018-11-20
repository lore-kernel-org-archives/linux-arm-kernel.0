From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:49:03 +0100
Subject: [RFC PATCH v2 08/14] clocksource/drivers/sun4i: register as
 sched_clock on suniv
In-Reply-To: <6f4773bdef8979bff71e958c9ca2c832c68ada0d.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <6f4773bdef8979bff71e958c9ca2c832c68ada0d.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120084903.v6v2m2sdiwdo34bd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 05:17:07PM +0300, Mesih Kilinc wrote:
> The suniv chip (newer F-series Allwinner SoCs) is based on ARM926EJ-S
> CPU, thus it has no architecture timer.
> 
> Register sun4i_timer as sched_clock on it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

This one should be squashed in the previous patch.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/b3c20907/attachment-0001.sig>
