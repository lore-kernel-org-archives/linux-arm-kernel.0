From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 26 Oct 2017 23:10:23 +0200
Subject: [PATCH] i2c/busses: Convert timers to use timer_setup()
In-Reply-To: <20171016232729.GA101069@beast>
References: <20171016232729.GA101069@beast>
Message-ID: <20171026211023.cu5yueotpj2qui5r@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 04:27:29PM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: linux-i2c at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171026/238164f8/attachment-0001.sig>
