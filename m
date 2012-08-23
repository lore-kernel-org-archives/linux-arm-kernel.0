From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Thu, 23 Aug 2012 09:35:18 +0300
Subject: JFFS2 issue with v3.5.x and later on Atmel chips at least (was:
 Kernel oops since v3.5.x on Atmel chips)
In-Reply-To: <5034F3F8.9080802@atmel.com>
References: <5034B45A.5060107@atmel.com> <5034F3F8.9080802@atmel.com>
Message-ID: <1345703718.2848.200.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-22 at 17:00 +0200, ludovic.desroches wrote:
> After bisection the commit causing this issue is:
> 
> commit 8bdc81c5069e43755d6e59e5e990e21ca200e8e2
> Author: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Date:   Mon May 7 19:56:53 2012 +0300
> 
>      jffs2: get rid of jffs2_sync_super

Thanks Ludovic for bisecting the issue, I'll take a look at this.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/f501db9f/attachment.sig>
