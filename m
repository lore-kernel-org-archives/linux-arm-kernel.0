From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 24 Jan 2011 15:29:17 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <20110124112103.GK16202@n2100.arm.linux.org.uk>
References: <4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
	<AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
	<AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
	<20110123180110.GJ30094@n2100.arm.linux.org.uk>
	<AANLkTiko9X_ua-ZAOZ-jEaAkPTKLCKyhgCHt6hbM5C-K@mail.gmail.com>
	<20110123230932.GK30094@n2100.arm.linux.org.uk>
	<AANLkTikw1wThEn0h+xv3mFaXVG8H45JUt2vqfECXnn6k@mail.gmail.com>
	<20110124112103.GK16202@n2100.arm.linux.org.uk>
Message-ID: <AANLkTiny78Ytuvh8CKUsjk6fOBa64kRj0z0-3MxSwvWK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> The rest of the combined patch looks sensible, so maybe 6630/1 should be
> combined into 6632/2 as well, and the above changes stripped out?

OK squashed them, took out the noop code and put in as 6632/3.

Linus Walleij
