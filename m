From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 6 Jan 2013 11:56:28 -0500
Subject: [PATCH 0/2] arm: cache-l2x0: aurora: Various bug fixes
In-Reply-To: <1355925387-9564-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355925387-9564-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130106165628.GA5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 02:56:25PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> Now that we have more devices and more boards supported, bugs shows
> up. Here are a couple of fixes that have been tested on Aramda XP
> based boards such as DB-78460-BP and DB-MV784MP-GP, and on Armada 370
> based boards such as DB-88F6710-BP-DDR3 and Mirabox. They are 3.8
> materials.
> 
> Thanks,
> 
> Gregory CLEMENT (2):
>   arm: cache-l2x0: aurora: Invalidate during clean operation with WT
>     enable
>   arm: cache-l2x0: aurora: Use writel_relaxed instead of writel
> 
>  arch/arm/mm/cache-l2x0.c |   31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Series:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
