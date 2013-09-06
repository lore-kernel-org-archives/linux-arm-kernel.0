From: davem@davemloft.net (David Miller)
Date: Thu, 05 Sep 2013 22:58:17 -0400 (EDT)
Subject: [PATCH] net: stmmac: fix bad merge conflict resolution
In-Reply-To: <1378429301-19964-1-git-send-email-olof@lixom.net>
References: <20130905.163725.106795517693348522.davem@davemloft.net>
 <1378429301-19964-1-git-send-email-olof@lixom.net>
Message-ID: <20130905.225817.700066425182547791.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>
Date: Thu,  5 Sep 2013 18:01:41 -0700

> Merge commit 06c54055bebf919249aa1eb68312887c3cfe77b4 did a bad conflict
> resolution accidentally leaving out a closing brace. Add it back.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> This breaks a handful of defconfigs on ARM, so it'd be good to see it
> applied pretty quickly. Thanks!

Looks like Linus applied this, thanks Olof.
