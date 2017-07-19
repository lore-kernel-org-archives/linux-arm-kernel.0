From: eric@anholt.net (Eric Anholt)
Date: Wed, 19 Jul 2017 13:21:07 -0700
Subject: [PATCH 2/2] arm64: dts: move rpi into rpi directory
In-Reply-To: <1500483950-9217-3-git-send-email-scott.branden@broadcom.com>
References: <1500483950-9217-1-git-send-email-scott.branden@broadcom.com>
 <1500483950-9217-3-git-send-email-scott.branden@broadcom.com>
Message-ID: <87mv80dvpo.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scott Branden <scott.branden@broadcom.com> writes:

> Place rpi into its own subdirectory.  This helps as the number
> of Broadcom boards grow and we can separate them per SoC.

It seems like pretty unnecessary churn to me, though I wouldn't
necessarily block it.  However, it conflicts with the patch I was
preparing yesterday to try to resolve our DT merging troubles
(https://lkml.org/lkml/2017/5/16/707), so I'd like to hold off on it for
now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/d69e3027/attachment.sig>
