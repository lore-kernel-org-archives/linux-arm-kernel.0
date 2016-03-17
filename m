From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 10:27:41 -0700
Subject: [PATCH 5/8] clk: bcm2835: add the dsi clocks
In-Reply-To: <1456760642-2412-6-git-send-email-kernel@martin.sperl.org>
References: <1456760642-2412-1-git-send-email-kernel@martin.sperl.org>
 <1456760642-2412-6-git-send-email-kernel@martin.sperl.org>
Message-ID: <87oaadj9pu.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add the missing dsi clocks using the currently "best known"
> parent-mux available for these clocks.

Having been working on DSI support, there is definitely no point in DSI0
and DSI1 pixel clocks without their proper parents and this patch would
just get in the way.  The esc clocks look fine, though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160317/365566ec/attachment.sig>
