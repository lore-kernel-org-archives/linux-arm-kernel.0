From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Feb 2018 09:00:36 -0800
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer in
 am335x-boneblue
In-Reply-To: <20180124212213.3754-1-brgl@bgdev.pl>
References: <20180124212213.3754-1-brgl@bgdev.pl>
Message-ID: <20180214170036.GL6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bartosz Golaszewski <brgl@bgdev.pl> [180124 13:22]:
> Using 'at' as the <manufacturer> part of the compatible string is now
> deprecated. Use a correct string: 'atmel,<model>'.

Applying into omap-for-v4.17/dt thanks.

Tony
