From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 31 May 2012 13:31:29 +0100
Subject: [PATCH] netwinder: encapsulate CPLD hardware locking and access
In-Reply-To: <86d35k7j2d.fsf_-_@gandalf.zerties.org>
References: <1338040464.2525.38.camel@koala>
 <20120525082812.GA12238@faui49q.informatik.uni-erlangen.de>
 <20120529100619.GA23186@faui49q.informatik.uni-erlangen.de>
 <1338040464.2525.38.camel@koala>
 <20120525082812.GA12238@faui49q.informatik.uni-erlangen.de>
 <20120529100619.GA23186@faui49q.informatik.uni-erlangen.de>
 <1338286268.11518.157.camel@shinybook.infradead.org>
 <1338040464.2525.38.camel@koala>
 <20120525082812.GA12238@faui49q.informatik.uni-erlangen.de>
 <20120529100619.GA23186@faui49q.informatik.uni-erlangen.de>
 <1338286268.11518.157.camel@shinybook.infradead.org>
 <86d35k7j2d.fsf_-_@gandalf.zerties.org>
Message-ID: <1338467489.11518.459.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-31 at 12:15 +0200, Christian Dietrich wrote:
> I hope my draft of the preemption disabling is not to much crap. I would
> appreciate some comments. And please be aware, that i don't own this
> hardware, and haven't tested it on real hardware therefore. 

Looks relatively sane at first glance; thanks.

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/574905d6/attachment-0001.bin>
