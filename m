From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 19:10:04 -0800
Subject: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
In-Reply-To: <201012172332.06480.jkrzyszt@tis.icnet.pl>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Message-ID: <20101218031003.GP5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101217 14:33]:
> Most keypad drivers make use of the <linux/input/matrix_keypad.h> 
> defined macros, structures and inline functions.
> 
> Convert omap-keypad driver to use those as well, as suggested by a 
> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
> 
> Created against linux-2.6.37-rc5.
> Tested on Amstrad Delta.
> Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to 
> board-h4.

Great, good to get rid of those annoying warnings!

>  drivers/input/keyboard/omap-keypad.c     |   36 ++++----
>  include/linux/input/matrix_keypad.h      |    2

We also need Dmitry's ack for these changes.

Regards,

Tony
