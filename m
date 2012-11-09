From: davem@davemloft.net (David Miller)
Date: Fri, 09 Nov 2012 16:39:48 -0500 (EST)
Subject: [PATCH net-next 1/2] ARM: net: bpf_jit_32: add XOR instruction
 for BPF JIT
In-Reply-To: <20121108012828.GA23143@thinkbox>
References: <20121108012828.GA23143@thinkbox>
Message-ID: <20121109.163948.606233183621652086.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <dxchgb@gmail.com>
Date: Thu, 8 Nov 2012 02:28:28 +0100

> This patch is a follow-up for patch "filter: add XOR instruction for use
> with X/K" that implements BPF ARM JIT parts for the BPF XOR operation.
> 
> Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
> Cc: Mircea Gherzan <mgherzan@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Could an ARM person please review and ACK these two patches so that
I can toss them into net-next (where the dependency is)?

Thanks!
