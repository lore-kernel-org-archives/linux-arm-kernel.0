From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Dec 2015 15:55:54 -0800
Subject: [PATCH] clk: bcm2835: added missing clock register definitions
In-Reply-To: <1450815189-3342-1-git-send-email-kernel@martin.sperl.org>
References: <1450815189-3342-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87oadfqu45.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Added missing CTRL and DIV clock register definitions for:
> PCM, SLIM, TCNT, TEC, TD0, TD1
>
> Register information taken from:
> https://rawgit.com/msperl/rpi-registers/master/rpi-registers.html#CM
> which extracted the information from the header files shared by
> Broadcom/rpi foundation in this file:
> http://www.broadcom.com/docs/support/videocore/Brcm_Android_ICS_Graphics_Stack.tar.gz
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

I had previously generated the list of registers by typing in a bunch of
them from specs, sorting, and adding missing ones for the clocks I meant
to expose.  I'm happy to see these missing registers added, even if we
haven't exposed those clocks yet.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/1682c739/attachment.sig>
