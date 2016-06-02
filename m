From: eric@anholt.net (Eric Anholt)
Date: Thu, 02 Jun 2016 11:06:10 -0700
Subject: [PATCH 03/32] irqchip: bcm2835: Avoid arch/arm-specific
 handle_IRQ.
In-Reply-To: <20160602005044.GN24391@io.lakedaemon.net>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-4-git-send-email-kraxel@redhat.com>
 <20160602005044.GN24391@io.lakedaemon.net>
Message-ID: <871t4fbh4d.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason Cooper <jason@lakedaemon.net> writes:

> Hey Gerd,
>
> On Wed, Jun 01, 2016 at 11:43:12PM +0200, Gerd Hoffmann wrote:
>> From: Eric Anholt <eric@anholt.net>
>> 
>> This is equivalent and works for arm64 as well.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>
> I don't mind taking this, or Eric's V2 resend.  However, the commit
> message needs a rewrite.

Can you clarify what you don't like about it or suggest replacement
wording?  This is the first concern I've seen.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160602/2ba94f16/attachment.sig>
