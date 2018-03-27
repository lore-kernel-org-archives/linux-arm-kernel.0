From: davem@davemloft.net (David Miller)
Date: Tue, 27 Mar 2018 10:00:51 -0400 (EDT)
Subject: [PATCH v7 0/7] netdev: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <044d58fd-b6ea-6341-0cdf-d99c47fc241e@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <20180326.124846.2182144342929084561.davem@davemloft.net>
 <044d58fd-b6ea-6341-0cdf-d99c47fc241e@codeaurora.org>
Message-ID: <20180327.100051.1676812408119987944.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 27 Mar 2018 08:40:41 -0400

> Are you able to drop the applied ones so that I can post V7 or is it
> too late?

I cannot "drop" changes from my tree since my tree is used by thousands
of people and therefore immutable.

You must therefore send me relative fixes or reverts.
