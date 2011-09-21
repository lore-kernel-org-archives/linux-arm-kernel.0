From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Sep 2011 13:28:30 +0200
Subject: [PATCH 0/11 v2] ARM: AT91: update gpio implementation
Message-ID: <20110921112830.GP24966@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	Today on at91 we use gpio != 0 as non valid gpio instead of the
	-EINVAL as define on the gpiolib so we can not use gpio_is_valid to
	check if a gpio is valid

	This patch series update the GPIO base addr to besoc independant and
	the gpio implemetation to start the first gpio as 0 and set -EINVAL
	for a non valid gpio

	So we will be complatible with the other implemenation as the AVR32

	we also update all the drivers

Best Regards,
J.
