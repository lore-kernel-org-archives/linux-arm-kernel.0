From: davem@davemloft.net (David Miller)
Date: Tue, 29 Dec 2015 15:53:14 -0500 (EST)
Subject: [RESEND PATCH v1 0/4] Add support emac for the RK3036 SoC platform
In-Reply-To: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
References: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20151229.155314.1522114236952280828.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


You have to submit this series properly, the same problem happend twice
now.

When you submit a series you should:

1) Make it clear which tree you expect these changes to be applied
   to.  Here it is completely ambiguous, do you want it to go into
   my networking tree or some other subsystem tree?

2) You MUST keep all parties informed about all patches for a series
   like this.  That means you cannot drop netdev from patch #4 as
   you did both times.  Doing this aggravates the situation for
   #1 even more, because if a patch is not CC:'d to netdev it does
   not enter patchwork.  And if it doesn't go into patchwork, I'm
   not looking at it.

Thanks.
