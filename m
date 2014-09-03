From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Sep 2014 14:47:16 -0700
Subject: [PATCH] ARM: dts: am437x-gp: switch i2c0 to 100KHz
In-Reply-To: <1409769981-17669-1-git-send-email-nm@ti.com>
References: <1409769981-17669-1-git-send-email-nm@ti.com>
Message-ID: <20140903214715.GO11766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140903 11:46]:
> On the GP EVM, the ambient light sensor is limited to 100KHz on the
> I2C bus.
> 
> So use 100kHz for I2C on the GP EVM due to this limitation on the
> ambient light sensor.
> 
> Reported-by: Aparna Balasubramanian <aparnab@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks applying into omap-for-v3.7/fixes-v2.

Tony
