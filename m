From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 4 Feb 2010 11:22:15 +0100
Subject: [PATCH 1/2] Modify PL031 for Nomadik and U8500 v2
In-Reply-To: <20100204104222.1e7ae094@linux.lan.towertech.it>
References: <1265273123-22421-1-git-send-email-linus.walleij@stericsson.com>
	<20100204104222.1e7ae094@linux.lan.towertech.it>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E6EDAFB@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Alessandro Z]

>  Ok. Be sure to have it tested on both versions
>  of the rtc.

There is not even a configuration in the kernel that
use the other version and this is a bit hard to test
without hardware, but I hope that Russell or someone
at ARM Ltd. will be willing to test (and update the
apropriate defconfigs)

>   Please also correct white lines between a function call
>  and the related if:

OK taking this out and putting it in Russells patch
tracker for consideration.

Thanks!

Yours,
Linus Walleij
