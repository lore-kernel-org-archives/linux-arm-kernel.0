From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 05 May 2010 08:55:48 +0300
Subject: [patch 1/2] kirkwood: allow machines to register RnB line with
	mtd driver
In-Reply-To: <20100429231313.519744154@fluff.org.uk>
References: <20100429231253.465019575@fluff.org.uk>
	<20100429231313.519744154@fluff.org.uk>
Message-ID: <1273038948.3702.56.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-04-30 at 00:12 +0100, Ben Dooks wrote:
> plain text document attachment (slinux)
> Add a kirkwood_nand_init_rnb() call to allow boards which
> have RnB line detection to register this instead of a
> static delay.
> 
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> Cc: Linux MTD <linux-mtd@lists.infradead.org>

I have this patch in l2-mtd-2.6 / dunno

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
