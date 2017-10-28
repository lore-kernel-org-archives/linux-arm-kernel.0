From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 28 Oct 2017 23:23:10 +0200 (CEST)
Subject: [PATCH] staging: vc04_services: Convert timers to use
 timer_setup()
In-Reply-To: <20171024082621.GA18529@beast>
References: <20171024082621.GA18529@beast>
Message-ID: <1430097289.60229.1509225790053@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Kees Cook <keescook@chromium.org> hat am 24. Oktober 2017 um 10:26 geschrieben:
> 
> 
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Michael Zoran <mzoran@crowfest.net>
> Cc: Keerthi Reddy <keerthigd4990@gmail.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devel at driverdev.osuosl.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
