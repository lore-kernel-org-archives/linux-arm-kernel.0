From: davem@davemloft.net (David Miller)
Date: Sun, 10 Mar 2013 17:12:38 -0400 (EDT)
Subject: [PATCH] ARM:net: an issue for k which is u32, never < 0
In-Reply-To: <513BECDA.3030803@asianux.com>
References: <513BECDA.3030803@asianux.com>
Message-ID: <20130310.171238.330349067962026661.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Gang <gang.chen@asianux.com>
Date: Sun, 10 Mar 2013 10:15:54 +0800

> 
>   k is u32 which never < 0, need type cast, or cause issue.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Who will apply this, ARM folks or me?
