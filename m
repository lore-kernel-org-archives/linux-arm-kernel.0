From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue, 7 Dec 2010 21:09:27 +1100
Subject: [PATCH] Added i2c support for mc13xxx-core
In-Reply-To: <AANLkTim-kgUjAB7DaMtnd8EHjcRjGTZG5NzN6C4idh40@mail.gmail.com>
References: <201012070854.21049.marc@cpdesign.com.au>
	<1291706087-6476-2-git-send-email-marc@cpdesign.com.au>
	<AANLkTim-kgUjAB7DaMtnd8EHjcRjGTZG5NzN6C4idh40@mail.gmail.com>
Message-ID: <201012072109.27892.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> What's your code base? I can not apply your patch.

I'm sorry, I'm not very good with git.
I'm working off the imx-for-2.6.38 branch (is that what you were asking?)

> You may also want to cc directly to u.kleine-koenig at pengutronix.de,
> sameo at linux.intel.com who are the module owner of mc13xxx-core.c.
Thanks for the heads up. CC'd them to this email, hopefully not too much 
effort to find my previous email(s) on the list. :) I welcome any comments 
before doing a V2 (a re-submit is obviously required anyway).

> 
> Cheers
> Yong

Thanks to you. 
At least this exercise has shown that your regulator code works for mc13892. I 
added all but VVIDEO, VAUDIO, VCAM and VCOINCELL to my board and the reported 
voltages for each reg were correct.

Cheers
Marc
