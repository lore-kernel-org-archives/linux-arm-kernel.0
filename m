From: lars.persson@axis.com (Lars Persson)
Date: Thu, 26 Oct 2017 16:24:16 +0200
Subject: [PATCH] drivers/crypto: Convert timers to use timer_setup()
In-Reply-To: <20171025101842.GA145495@beast>
References: <20171025101842.GA145495@beast>
Message-ID: <4621befa-e5f5-182f-e72a-5f3277d4675f@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/25/2017 12:18 PM, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lars Persson <lars.persson@axis.com>
> Cc: Niklas Cassel <niklas.cassel@axis.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: linux-arm-kernel at axis.com
> Cc: linux-crypto at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

For drivers/crypto/axis:
Acked-by: Lars Persson <lars.persson@axis.com>

Thanks,
  Lars
