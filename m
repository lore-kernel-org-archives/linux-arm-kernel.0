From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Nov 2015 14:12:39 -0800
Subject: [PATCHv2 2/4] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <1448816373-18235-3-git-send-email-alex.aring@gmail.com>
References: <1448816373-18235-1-git-send-email-alex.aring@gmail.com>
 <1448816373-18235-3-git-send-email-alex.aring@gmail.com>
Message-ID: <87vb8jgmqw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").
>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Acked-by: Eric Anholt <eric@anholt.net>

I'm still hoping Ulf will pull this patch along with the genpd change,
to reduce synchronization between trees.  (That just leaves the DT
change's dependency on the header in this one).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/2311a782/attachment.sig>
