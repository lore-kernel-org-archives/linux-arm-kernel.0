From: horms@verge.net.au (Simon Horman)
Date: Mon, 7 Dec 2015 15:43:42 +0900
Subject: [PATCH] ARM: shmobile: r8a7793: remove deprecated
 #gpio-range-cells
In-Reply-To: <20151126090055.GA1531@katana>
References: <1448511980-12173-1-git-send-email-horms+renesas@verge.net.au>
 <20151126090055.GA1531@katana>
Message-ID: <20151207064342.GJ22834@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 10:00:55AM +0100, Wolfram Sang wrote:
> On Thu, Nov 26, 2015 at 01:26:20PM +0900, Simon Horman wrote:
> > Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
> > declares the above property deprecated. That was more than 2 years ago.
> > Remove it, so it doesn't get copied around needlessly.
> > 
> > Based on similar work for the r8a7791 and r8a7794 by Wolfram Sang.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up.
