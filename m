From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 25 Sep 2009 10:12:21 +0300
Subject: [PATCH 06/12] omap: mailbox: Flush posted write when acking
	mailbox irq
In-Reply-To: <20090924233920.6065.16789.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
	<20090924233920.6065.16789.stgit@localhost>
Message-ID: <4ABC6D55.3000108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2009 02:39 AM, Tony Lindgren wrote:
> From: Hiroshi DOYU<Hiroshi.DOYU@nokia.com>
>
> The only way to flush posted write to L4 bus is to do a read back
> of the same register right after the write.

Just curious, is it really necessary to read back the _same_ register?
Would reading back any L4 bus-related register be sufficient?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
