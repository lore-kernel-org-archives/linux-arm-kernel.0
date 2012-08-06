From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 06 Aug 2012 13:58:32 +0200
Subject: [PATCH 2/2] dma-buf: add helpers for attacher dma-parms
In-Reply-To: <501F9C8E.4080002@samsung.com>
References: <1342715014-5316-1-git-send-email-rob.clark@linaro.org>
 <1342715014-5316-3-git-send-email-rob.clark@linaro.org>
 <501F9C8E.4080002@samsung.com>
Message-ID: <xa1tobmoxmdz.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Tomasz Stanislawski <t.stanislaws@samsung.com> writes:
> I recommend to change the semantics for unlimited number of segments
> from 'value 0' to:
>
> #define DMA_SEGMENTS_COUNT_UNLIMITED ((unsigned long)INT_MAX)
>
> Using INT_MAX will allow using safe conversions between signed and
> unsigned integers.

LONG_MAX seems cleaner regardless.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120806/977107ce/attachment.sig>
