From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Thu, 20 Sep 2012 10:13:28 -0300
Subject: [PATCH] gpio-lpc32xx: Fix value handling of
 gpio_direction_output()
In-Reply-To: <1348130883-11329-1-git-send-email-stigge@antcom.de>
References: <1348130883-11329-1-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30GdYj-Kcb_qu4QEv-eqy5=kp0HS4V2-f4QSVhyo07xrBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 5:48 AM, Roland Stigge <stigge@antcom.de> wrote:
> For GPIOs of gpio-lpc32xx, gpio_direction_output() ignores the value argument
> (initial value of output). This patch fixes this by setting the level
> accordingly.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Nice catch.
