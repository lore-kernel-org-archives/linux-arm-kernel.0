From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 17:06:33 +0200
Subject: [PATCH] ARM: sun4i: cubieboard: Enable the i2c controllers
In-Reply-To: <51827215.100@elopez.com.ar>
References: <1367498266-1246-1-git-send-email-emilio@elopez.com.ar>
 <2206623.mnYPZ5KTnx@wuerfel> <51827215.100@elopez.com.ar>
Message-ID: <201305021706.33456.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Emilio L?pez wrote:
> This is complementary to the series titled "Add I2C support for
> Allwinner SoCs" sent by Maxime today. We have no driver for the AXP20
> PMIC yet, and the external header is left for the user to connect, so I
> haven't added any device. This is still useful though, as it lets you
> use I2C from userspace (i2cdetect, i2cdump, etc).

Right, that makes sense. Thanks,

	Arnd
