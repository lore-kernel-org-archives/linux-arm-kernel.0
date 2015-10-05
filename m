From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Oct 2015 17:27:06 +0200
Subject: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
In-Reply-To: <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20151005152706.GC17612@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 16, 2015 at 11:23:46AM +0200, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
> 
> Get and use the slow clock as it is necessary for the timer counters.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm at vger.kernel.org
>  drivers/clocksource/tcb_clksrc.c | 10 +++++++++-
>  drivers/misc/atmel_tclib.c       |  4 ++++
>  drivers/pwm/pwm-atmel-tcb.c      | 26 +++++++++++++++++++-------
>  include/linux/atmel_tc.h         |  1 +
>  4 files changed, 33 insertions(+), 8 deletions(-)

This doesn't seem to apply anymore. Does it need to be rebased? Or do I
need some other patch as a dependency?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/a4bba5ae/attachment.sig>
