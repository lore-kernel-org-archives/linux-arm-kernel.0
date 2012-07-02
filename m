From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Jul 2012 11:38:14 -0600
Subject: 3ad1308 pwm: tegra: Add device tree support
Message-ID: <4FF1DC86.1030508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

Could I ask you to apply a small fix to the following commit in your pwm
for-next tree:

3ad1308 pwm: tegra: Add device tree support

The pwm node is added in the wrong place; the nodes should be sorted
numerically by address in the reg property, which would put the addition
between serial and i2c, not between i2c and pmc.

If you're unable to rebase that branch for some reason, I can send an
incremental patch to do that.

Thanks.
