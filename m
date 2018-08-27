From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 27 Aug 2018 18:19:34 +0200
Subject: [PATCH v2 7/7] drm/i2c: tda998x: register bridge outside of
 component helper
In-Reply-To: <E1fkBFl-00049E-3F@rmk-PC.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <CGME20180731072546epcas3p26bba2e6e1b88b838204dd0ca15664cb7@epcas3p2.samsung.com>
 <E1fkBFl-00049E-3F@rmk-PC.armlinux.org.uk>
Message-ID: <20180827161936eucas1p11ded51b7dd72e8326a12a9908ecf95c4~OyiNWx9wd1378213782eucas1p1y@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2018 18:42, Russell King wrote:
> Register the bridge outside of the component helper as we have
> drivers that wish to use the tda998x without its encoder.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
