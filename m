From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2011 11:07:18 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <4DDBC8C7.4000001@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<BANLkTi=8vX1Cs_fzpQXZBuuDuLYLu1FGmg@mail.gmail.com>
	<4DDA2AC0.1060406@gaisler.com>
	<20110523095829.GG17672@n2100.arm.linux.org.uk>
	<BANLkTink1rrC8F3Gjhqt84gYzOibX+AgDQ@mail.gmail.com>
	<4DDBC8C7.4000001@gmail.com>
Message-ID: <BANLkTin4xKHbxysxN8M-5AP2143VkoLG=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/24 Rob Herring <robherring2@gmail.com>:

> I think having "arm,amba-deviceid" is not needed. The current code does
> nothing but warn if it doesn't match the h/w value. The drivers already have
> a list of id's that they support and the amba bus only matches against the
> h/w id value. The only use I can see is overriding a broken h/w value.

We have this usecase in the Ux500. See these patches:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6829/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6830/1

Alas, it's not yet merged for the old boardfile world usecase, and
causing us problems to drive our hardware already.

Yours,
Linus Walleij
