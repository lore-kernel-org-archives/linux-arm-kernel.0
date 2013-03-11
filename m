From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Mar 2013 16:47:41 +0000
Subject: [PATCH] ARM:net: an issue for k which is u32, never < 0
In-Reply-To: <20130310.171238.330349067962026661.davem@davemloft.net>
References: <513BECDA.3030803@asianux.com>
 <20130310.171238.330349067962026661.davem@davemloft.net>
Message-ID: <20130311164741.GL4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 10, 2013 at 05:12:38PM -0400, David Miller wrote:
> From: Chen Gang <gang.chen@asianux.com>
> Date: Sun, 10 Mar 2013 10:15:54 +0800
> 
> > 
> >   k is u32 which never < 0, need type cast, or cause issue.
> > 
> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> 
> Who will apply this, ARM folks or me?

I'm happy if you wish to take the patch:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
