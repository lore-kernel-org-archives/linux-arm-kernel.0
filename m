From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 03 May 2012 17:19:51 -0600
Subject: Stable I2C branch needed as a dependency for Tegra change
Message-ID: <4FA31297.8000904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

A change I'd like to make for Tegra in 3,5:

http://www.spinics.net/lists/arm-kernel/msg172756.html

relies on an I2C change that's also scheduled for 3.5:

http://www.spinics.net/lists/linux-i2c/msg07808.html
(which is already committed as 1475e39 "of/i2c: implement
of_find_i2c_adapter_by_node")

Is your i2c-embedded/for-next branch stable (i.e. that commit will not
be rebased between now and when you send a pull request for 3.5), so I
can use it as a baseline for a Tegra branch? If not, could you let me
know when it is stable, so I can create the Tegra branch as that time.

Thanks!
