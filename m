From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Fri, 17 Dec 2010 20:29:30 -0800
Subject: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
In-Reply-To: <201012172332.06480.jkrzyszt@tis.icnet.pl>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
Message-ID: <AANLkTim3nFfo4PGf+krOJCsacxDuGyavvt4Pev3MWPj3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 2:32 PM, Janusz Krzysztofik
<jkrzyszt@tis.icnet.pl> wrote:
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
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---

Works perfectly on the herald, and no more warning message.  Good work!

Tested-by: Cory Maccarrone <darkstar6262@gmail.com>

- Cory
