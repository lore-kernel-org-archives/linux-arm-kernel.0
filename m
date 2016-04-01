From: davem@davemloft.net (David Miller)
Date: Fri, 01 Apr 2016 14:37:28 -0400 (EDT)
Subject: [PATCH] net: mvpp2: fix maybe-uninitialized warning
In-Reply-To: <1459414883-6295-1-git-send-email-jszhang@marvell.com>
References: <1459414883-6295-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160401.143728.2154823165656728049.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Thu, 31 Mar 2016 17:01:23 +0800

> This is to fix the following maybe-uninitialized warning:
> 
> drivers/net/ethernet/marvell/mvpp2.c:6007:18: warning: 'err' may be
> used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied.
