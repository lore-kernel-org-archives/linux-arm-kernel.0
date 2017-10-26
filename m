From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 26 Oct 2017 14:54:29 +0100
Subject: [PATCH] drivers/crypto: Convert timers to use timer_setup()
In-Reply-To: <20171025101842.GA145495@beast>
References: <20171025101842.GA145495@beast>
Message-ID: <20171026135429.sk3s6ama2na7bvim@ash>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 25, 2017 at 03:18:42AM -0700, Kees Cook wrote:
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
> ---

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks,

Jamie
