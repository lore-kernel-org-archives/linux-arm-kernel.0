From: mnazarewicz@google.com (Michal Nazarewicz)
Date: Thu, 24 Feb 2011 23:24:19 +0100
Subject: [PATCH 1/2] lib: vsprintf: optimised put_dec() function
In-Reply-To: <20110224141818.7fd0207f.akpm@linux-foundation.org>
References: <a02a83033d5d61c5d78f110b44f24ae5cd94ab06.1298384703.git.mina86@mina86.com>
	<20110224135101.9205d91e.akpm@linux-foundation.org>
	<op.vrfg66mgvgw7ix@mnazarewicz-glaptop>
	<20110224141818.7fd0207f.akpm@linux-foundation.org>
Message-ID: <op.vrfhus0ivgw7ix@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> On Thu, 24 Feb 2011 22:52:42 +0100, Andrew Morton wrote:
>> > Also, the funky indenting to align on the "=" is atypical for kernel
>> > code and is inconsistent with the rest of vsprintf.c.  Just a single
>> > space, please.

> On Thu, 24 Feb 2011 23:10:09 +0100 "Michal Nazarewicz" wrote:
>> Want me to resubmit with spaces fixed?

On Thu, 24 Feb 2011 23:18:18 +0100, Andrew Morton wrote:
> nah, we'll live.
>
> I'd prefer that you find a workload where it actually matters :)

I'll try. :) Still have Contiguous Memory Allocator to work on. ;)
Thanks!

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
