From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 17 May 2016 11:07:47 +0300
Subject: More build fixes for omapdrm in current -next
In-Reply-To: <1462982509-342936-1-git-send-email-arnd@arndb.de>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
Message-ID: <573AD153.4060200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/16 19:01, Arnd Bergmann wrote:
> A couple more errors showed up in linux-next in the last few
> days, all because of missing header files. I have not seen these
> before, and most configurations appear to be fine. There
> must have been an implicit inclusion somewhere before that
> just got removed, but I couldn't find it and doing the
> explicit #include should always be better here.

Thanks. I picked the first one as is, and third one with some conflict
resolutions. A patch similar to the second one was already queued.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160517/6a3a8145/attachment.sig>
