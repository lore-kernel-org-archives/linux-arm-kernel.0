From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Jul 2014 10:30:18 +0200
Subject: [PATCH 0/2] ARM: shmobile: Remove early_printk from command line
In-Reply-To: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
References: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140709083018.GG5656@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 08:50:07AM +0200, Simon Horman wrote:
> As early printk is not supported when devices are initialised
> using DT, so remove it from the command line.
> 
> Based on renesas-devel-v3.16-rc3-20140706.
> 
> Simon Horman (2):
>   ARM: shmobile: armadillo800eva-reference: Remove early_printk from
>     command line
>   ARM: shmobile: kzm9g-reference: Remove early_printk from command line

I have queued these up.
