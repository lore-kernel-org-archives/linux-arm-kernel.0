From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 1 Oct 2011 12:39:21 +0200
Subject: [PATCH] drivers: create a pin control subsystem v8
In-Reply-To: <CACxGe6v19pZ0i-+ksYZbG2ZvGT30UkXEHTzpZMBTB4RNUV5bnA@mail.gmail.com>
References: <1317211419-18472-1-git-send-email-linus.walleij@stericsson.com>
	<20110930020754.GK12606@ponder.secretlab.ca>
	<CACRpkdYyyqB6=5M8reqgwpMxXJz5ttXWyOav6K58dQ0CrxwCNA@mail.gmail.com>
	<CACxGe6v19pZ0i-+ksYZbG2ZvGT30UkXEHTzpZMBTB4RNUV5bnA@mail.gmail.com>
Message-ID: <CAKnu2MpQ8Wvd4TF8Ge=o8ACyEoaEY8TcvOSdT1w6zfYiSKFUiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/30 Grant Likely <grant.likely@secretlab.ca>:

>?I'm not convinced that the sysfs approach is
> actually the right interface here (I'm certainly not a fan of the gpio
> sysfs i/f), and I'd rather not be putting in unneeded stuff until the
> userspace i/f is hammered out.

Actually, thinking about it I cannot see what would be wrong
with /dev/gpio0 & friends in the first place.

Using sysfs as swiss army knife for custom I/O does not
seem like it would be long-term viable so thanks for this
observation, and I think we need /dev/gpio* put on some
mental roadmap somewhere.

Yours,
Linus Walleij
