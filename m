From: davem@davemloft.net (David Miller)
Date: Fri, 27 Oct 2017 12:10:02 +0900 (KST)
Subject: [PATCH] drivers/net: nuvoton: Convert timers to use timer_setup()
In-Reply-To: <20171025105158.GA146575@beast>
References: <20171025105158.GA146575@beast>
Message-ID: <20171027.121002.2042844769656745749.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 25 Oct 2017 03:51:58 -0700

> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
