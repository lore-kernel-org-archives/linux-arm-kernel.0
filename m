From: davem@davemloft.net (David Miller)
Date: Mon, 13 Oct 2014 12:06:18 -0400 (EDT)
Subject: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <20141013114428.GA28113@linaro.org>
References: <87d29w1rf7.fsf@linux.vnet.ibm.com>
 <20141013.012146.992477977260812742.davem@davemloft.net>
 <20141013114428.GA28113@linaro.org>
Message-ID: <20141013.120618.1470323732942174784.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@linaro.org>
Date: Mon, 13 Oct 2014 12:44:28 +0100

> Also, as a heads up for Sparc. I don't see any definition of
> __get_user_pages_fast. Does this mean that a futex on THP tail page
> can cause an infinite loop?

I have no idea, I didn't realize this was required to be implemented.
