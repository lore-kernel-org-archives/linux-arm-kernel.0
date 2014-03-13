From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 12 Mar 2014 23:39:40 -0700
Subject: [PATCH v5 0/8] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20140312081350.GC30808@shlinux2.ap.freescale.net>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <20140312081350.GC30808@shlinux2.ap.freescale.net>
Message-ID: <20140313063940.GU31517@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:13:51PM +0800, Huang Shijie wrote:
> On Mon, Feb 24, 2014 at 06:37:34PM +0800, Huang Shijie wrote:
>    Could you please review this patch set? I really hope it can be merged
>    as soon as possibel.  But now, the patch set has stalled for a long time.

I'm sorry for the delay. Others are in the same position of delay (e.g.,
Lee's SPI-NOR driver), because I simply have not had the time to really
devote this the attention it deserves, especially considering how it
rearchitects such an important, commonly-used driver.

Nonetheless, I will try to give your patches some more attention soon.

>    Since you have pushed the patches for m25p80.c, i have to rebase this
>    patch set again and again...

You mean locally? I promise you, I can handle rebasing on my reviewing
end for small one-line conflicts like new chip IDs, so don't rebase and
resend simply for that. Unless I find substantive things that you should
change, I'd only expect at most one more rebase to be necessary.

Brian
