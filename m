From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 17 Oct 2017 19:48:09 +0200
Subject: [PATCH] arm: pxa: Convert timers to use timer_setup()
In-Reply-To: <20171016234852.GA102339@beast> (Kees Cook's message of "Mon, 16
 Oct 2017 16:48:52 -0700")
References: <20171016234852.GA102339@beast>
Message-ID: <87a80pfyxy.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kees Cook <keescook@chromium.org> writes:

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. Adds a static variable to hold the
> interrupt private data pointer.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to pxa/for-next tree, thanks.

--
Robert
