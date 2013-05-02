From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 May 2013 15:43:27 +0200
Subject: [PATCH] ARM: sun4i: cubieboard: Enable the i2c controllers
In-Reply-To: <1367498266-1246-1-git-send-email-emilio@elopez.com.ar>
References: <1367498266-1246-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <2206623.mnYPZ5KTnx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013 09:37:46 Emilio L?pez wrote:
> The Cubieboard makes use of the first two i2c controllers found on the
> Allwinner A10; i2c-0 is used internally for the PMIC, while i2c-1
> is exposed on the board headers. This patch enables them in the device
> tree.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Shouldn't you list the attached devices in the same patch?

What is the point of enabling the I2C bus if there are no devices
to be found?

	Arnd
