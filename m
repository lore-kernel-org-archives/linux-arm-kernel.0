From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Oct 2013 15:16:46 +0100
Subject: [PATCH] MAINTAINERS: Add patterns for DTS files for AT91
In-Reply-To: <525E9C29.7010301@atmel.com>
References: <1381921447-21811-1-git-send-email-broonie@kernel.org>
 <525E9C29.7010301@atmel.com>
Message-ID: <20131016141646.GM2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 04:01:13PM +0200, Nicolas Ferre wrote:
> On 16/10/2013 13:04, Mark Brown :

> >+F:	arch/arm/boot/dts/at91*.dts
> >+F:	arch/arm/boot/dts/at91*.dtsi

> Unfortunately, we added some more strings for our new C-A5 product
> family. I tried to be more generic possible without messing with
> other product names. So what about adding these lines?

> +F:	arch/arm/boot/dts/sama*.dts
> +F:	arch/arm/boot/dts/sama*.dtsi

> If it is okay with you, I can add them directly in your patch when
> taking it in my tree, do not bother.

Sure, that's fine by me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/069331c4/attachment.sig>
