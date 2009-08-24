From: dave@chronolytics.com (David F. Carlson)
Date: Mon, 24 Aug 2009 17:49:30 -0400 (EDT)
Subject: 6410 issues with samsung-ap-2.6
Message-ID: <200908242149.n7OLnU6d017655@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


List-ies,

I am (trying) to use the recently released git kki_ap/samsung-ap-2.6 which is supposedly a decent 6410 tree.

I am having trouble with the the input gpio_keys code that does a "gpio_to_irq()" to get the gpio to irq mapping.

This call always fails for the 6410 (ENXIO).  I see no code for the 6410 to get a irq.

Is there a better tree to integrate my 6410-based device with?  (I am having other "issues" with this git tree and the samsung folks are not helpful...)

Thanks in advance,

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
