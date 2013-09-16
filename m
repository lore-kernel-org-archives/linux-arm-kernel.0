From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Sep 2013 19:28:07 +0100
Subject: mvneta: oops in __rcu_read_lock on mirabox
In-Reply-To: <20130916174708.GG3188@1wt.eu>
References: <CACzLR4tTvt+ROEhkXUCQhV6=bPPTX4LFSkWfrEhF+OdM1Jm1Rw@mail.gmail.com>
 <20130915205701.5c61a444@skate> <20130916065047.GH27487@1wt.eu>
 <20130916175152.4e013457@skate>
 <CACzLR4twTNjzU8hK3L1cYUXnEH1ydwY6jnYoOG+9vLB3-4uQ4w@mail.gmail.com>
 <20130916163937.GC3188@1wt.eu> <20130916164412.GD3188@1wt.eu>
 <CACzLR4ssOPsmYaEh2ohe4HL5j+67keDYnmR4YezNB=aO7Pj5kA@mail.gmail.com>
 <20130916174708.GG3188@1wt.eu>
Message-ID: <20130916182807.GO12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 07:47:08PM +0200, Willy Tarreau wrote:
> I'll have to rebuild with your config and exact 3.11 to test again.
> Can you check the packet rate of your ping flood to give an order of
> magnitude so that we're sure to be in the same conditions ?

Also, try swapping kernel binaries between yourselves, so that you can
be sure you're running the exact same kernel on different hardware.
