From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Jan 2018 11:06:12 +0100
Subject: [PATCH] arm64: dts: marvell: armada-80x0: Fix pinctrl
 compatible string
In-Reply-To: <20180112100002.3967-1-gregory.clement@free-electrons.com>
References: <20180112100002.3967-1-gregory.clement@free-electrons.com>
Message-ID: <20180112110612.223da2d9@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 12 Jan 2018 11:00:02 +0100, Gregory CLEMENT wrote:
> When replacing the cpm by cp0 and cps by cp1 [1] not only the label and
> the alias were replaced but also the compatible string which was wrong.
> 
> Due to this the pinctrl driver was no more probed.
> 
> This patch fix it by reverting this change for the pinctrl compatible
> string on Armada 8K.
> 
> [1]: "arm64: dts: marvell: replace cpm by cp0, cps by cp1"

It is normally recommended to give the commit ID, i.e:

In commit 01b451ed3bd2 ("arm64: dts: marvell: replace cpm by cp0, cps
by cp1"), ...

> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks for fixing this mistake!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
