From: david.wu@rock-chips.com (David.Wu)
Date: Tue, 4 Jul 2017 15:37:54 +0800
Subject: [PATCH 4/5] pwm: rockchip: Add atomic updated feature for rk3328
In-Reply-To: <20170703203957.03f3d1db@bbrezillon>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
 <1498739271-27431-5-git-send-email-david.wu@rock-chips.com>
 <20170703203957.03f3d1db@bbrezillon>
Message-ID: <05cccb3d-2b35-1878-6173-9a96adef17ba@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

? 2017/7/4 2:39, Boris Brezillon ??:
> Yet another customization. Don't you think we can extract common parts,
> expose them as helpers and then have 3 different pwm_ops (with 3
> different ->apply() implementation), one for each IP revision.

Sounds reasonable.I will try to implement 3 different apply().
