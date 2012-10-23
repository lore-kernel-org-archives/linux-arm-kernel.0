From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 23 Oct 2012 15:16:27 +0200
Subject: [PATCH 0/2] qt1070 & gpio_keys add pinctrl consumer
Message-ID: <20121023131627.GE18964@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	The following patch series add the pinctrl support to the follwing
	keybords:

	 - gpio_keys
	 - qt1070

	The pinctrl is optionnal as not everyone need it

	If no objection I'll apply them via at91 as I have a long patch series
	of pinctrl for at91

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      input: qt1070: add pinctrl consumer
      input: gpio_keys: add pinctrl consumer

 drivers/input/keyboard/gpio_keys.c |   11 +++++++++++
 drivers/input/keyboard/qt1070.c    |   11 +++++++++++
 2 files changed, 22 insertions(+)

Best Regards,
J.
