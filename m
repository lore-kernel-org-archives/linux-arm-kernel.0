From: davem@davemloft.net (David Miller)
Date: Tue, 05 Jul 2011 22:30:45 -0700 (PDT)
Subject: [PATCH v2 0/3] Add device tree probe support for imx fec driver
In-Reply-To: <20110705.194854.1875695946300840388.davem@davemloft.net>
References: <1309878839-25743-1-git-send-email-shawn.guo@linaro.org>
	<20110705.194854.1875695946300840388.davem@davemloft.net>
Message-ID: <20110705.223045.738515407552627580.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jul 2011 19:48:54 -0700 (PDT)

> All applied to net-next-2.6, thanks.

Come on guys:

drivers/of/of_net.c: In function 'of_get_phy_mode':
drivers/of/of_net.c:45: error: implicit declaration of function 'of_property_read_string'

This is completely rediculious.

Don't tell me that it's appropriate to merge something into
my net tree when it uses interfaces that don't even exist
in Linus's tree.
