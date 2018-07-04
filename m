From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Jul 2018 17:44:37 +0200
Subject: [PATCH] drm/sun4i: Remove VLA usage
In-Reply-To: <20180629184740.GA37415@beast>
References: <20180629184740.GA37415@beast>
Message-ID: <20180704154437.dcjsghcsxikry2xn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2018 at 11:47:40AM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a kmalloc allocation and moves all the size calculations
> to the start to do an allocation. If an upper bounds on the mode timing
> calculations could be determined, a fixed stack size could be used instead.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA at mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/553477ce/attachment-0001.sig>
