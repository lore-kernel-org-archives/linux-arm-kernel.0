From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 3 Nov 2010 11:18:37 +0100
Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <956998.65651.qm@web180302.mail.gq1.yahoo.com>
References: <1288124308-14999-9-git-send-email-cyril@ti.com>
	<956998.65651.qm@web180302.mail.gq1.yahoo.com>
Message-ID: <AANLkTin=3K0H+YdNM2Nhz63c3+Upp+rwApo-Ww4p5qH6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/3 David Brownell <david-b@pacbell.net>:

> That seems like
> a better structure for various vendors' "SSP"
> hardware (multifunction serial interface logic)

Incidentally the ARM PrimeCell PL022 is called SSP,
"Synchronous Serial Port" and is not multifunction at all.
Just to add to the confusion...

Yours,
Linus Walleij
