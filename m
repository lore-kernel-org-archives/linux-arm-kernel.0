From: eric@anholt.net (Eric Anholt)
Date: Tue, 07 Jun 2016 13:30:41 -0700
Subject: [PATCH] ARM: bcm2835: remove unused __packet
In-Reply-To: <1465321773-21519-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465321773-21519-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <87shwo68su.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> The driver defines a variable called __packet but then never
> uses it, and does not export it for others to use either. Fix
> the warning about undeclared variable by removing it.
>
> drivers/soc/bcm/raspberrypi-power.c:48:3: warning: symbol '__packet' was not declared. Should it be static?

Reviewed-by: Eric Anholt <eric@anholt.net>

PM folks: I'd be happy to see this go through your trees, but either way
is fine with me.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/e7c75853/attachment.sig>
