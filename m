From: eric@anholt.net (Eric Anholt)
Date: Mon, 26 Oct 2015 11:27:27 -0700
Subject: [PATCH soc/next] ARM: bcm2835: add mutual inclusion protection
In-Reply-To: <1445539565-24955-1-git-send-email-alex.aring@gmail.com>
References: <1445539565-24955-1-git-send-email-alex.aring@gmail.com>
Message-ID: <87vb9t4h9s.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds mutual inclusion protection for the rpi firmware header.
>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> This patch is for "soc/next" and depends on Eric Anholt's patch ("ARM: bcm2835:
> Add the Raspberry Pi firmware driver"), see:
>
> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-October/002434.html
>
> I think the patch is already applied but not pushed, so please fixup use this
> as fixup or simple apply this patch after the patch to add the firmware driver.

Looks like Florian pulled this in to his pull request and it's in the
arm-soc tree.

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151026/6d78cd2f/attachment.sig>
