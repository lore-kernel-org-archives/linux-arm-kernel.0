From: davem@davemloft.net (David Miller)
Date: Tue, 13 Nov 2012 18:21:28 -0500 (EST)
Subject: [PATCH net-next 1/2] ARM: net: bpf_jit_32: add XOR instruction
 for BPF JIT
In-Reply-To: <50A2D0F4.3090202@gmail.com>
References: <20121108012828.GA23143@thinkbox>
	<50A2D0F4.3090202@gmail.com>
Message-ID: <20121113.182128.474002768931513696.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mircea Gherzan <mgherzan@gmail.com>
Date: Wed, 14 Nov 2012 00:00:04 +0100

> Am 08.11.2012 02:28, schrieb Daniel Borkmann:
>> This patch is a follow-up for patch "filter: add XOR instruction for use
>> with X/K" that implements BPF ARM JIT parts for the BPF XOR operation.
>> 
>> Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
 ...
> Acked-by: Mircea Gherzan <mgherzan@gmail.com>

Applied, thanks for reviewing.
