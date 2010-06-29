From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 29 Jun 2010 09:47:48 +0300
Subject: [PATCH] ixp4xx: add support for static flash partitions
In-Reply-To: <20100614161519.GB24877@riccoc20.at.omicron.at>
References: <20100531162434.GA4599@riccoc20.at.omicron.at>
	<1276420566.19028.184.camel@localhost>
	<20100614161519.GB24877@riccoc20.at.omicron.at>
Message-ID: <1277794068.1041.971.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-14 at 18:15 +0200, Richard Cochran wrote:
> On Sun, Jun 13, 2010 at 12:16:06PM +0300, Artem Bityutskiy wrote:
> > I could fix your patch up myself, but I do not know the code, so please,
> > re-send a patch against the latest mtd-2.6 tree.
> 
> Okay, here it is again, this time against today's master branch of 
> git://git.infradead.org/mtd-2.6.git
> 
> Thanks,
> Richard
> 
> 
> This patch adds support for static flash partitioning from a platform
> device. Also, we clean up some weirdness where statements were separated
> by commas instead of semicolons. While we are at it, fix some minor bad
> white space, too.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Pushed to l2-mtd-2.6.git / dunno.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
