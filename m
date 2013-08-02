From: davem@davemloft.net (David Miller)
Date: Fri, 02 Aug 2013 12:34:42 -0700 (PDT)
Subject: [PATCH V3 0/3] networking: Use ETH_ALEN where appropriate
In-Reply-To: <cover.1375398692.git.joe@perches.com>
References: <20130801.143137.331385226409040561.davem@davemloft.net>
 <cover.1375398692.git.joe@perches.com>
Message-ID: <20130802.123442.500196593983076682.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Thu,  1 Aug 2013 16:17:46 -0700

> Convert the uses mac addresses to ETH_ALEN so
> it's easier to find and verify where mac addresses
> need to be __aligned(2)

Series applied to net-next, thanks.
