From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 19 Mar 2013 09:33:24 -0400
Subject: [BUG][mvebu] mvneta: cannot request irq 25 on openblocks-ax3
In-Reply-To: <51486445.8040506@hitachi.com>
References: <51486445.8040506@hitachi.com>
Message-ID: <20130319133324.GS13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 10:12:37PM +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here I've hit a bug on the recent kernel. As far as I know, this bug
> exists on 3.9-rc1 too.
> 
> When I tried the latest mvebu for-next tree
> (git://git.infradead.org/users/jcooper/linux.git mvebu/for-next),

FYI: that branch isn't stable, it's used as a merge-test of
arm-soc/for-next (also not stable) and any branches I am trying to push
upstream that day.

Gregory has a patch in the works for this.  Hopefully he'll submit
it by the end of the week.

thx,

Jason.
