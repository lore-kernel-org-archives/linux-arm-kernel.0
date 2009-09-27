From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 27 Sep 2009 21:11:39 +0200
Subject: [PATCH] Make MMCI driver compile without gpiolib
In-Reply-To: <20090927153108.GA20093@n2100.arm.linux.org.uk>
References: <1251276988-27882-1-git-send-email-linus.walleij@stericsson.com>
	<20090927153108.GA20093@n2100.arm.linux.org.uk>
Message-ID: <63386a3d0909271211uabf23d9m7e0b8d87d99d77be@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Looking back at this, I don't think this ifdef is required.

You're righ of course, sorry for that. Fix-up patch just posted,
also in the patch tracker. Reverts these #ifdef:s and fix the root
problem instead.

Linus Walleij
