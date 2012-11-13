From: davem@davemloft.net (David Miller)
Date: Tue, 13 Nov 2012 18:21:37 -0500 (EST)
Subject: [PATCH net-next 2/2] ARM: net: bpf_jit_32: add VLAN
 instructions for BPF JIT
In-Reply-To: <50A2D114.8080306@gmail.com>
References: <20121108013101.GB23143@thinkbox>
	<50A2D114.8080306@gmail.com>
Message-ID: <20121113.182137.290728881555855814.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mircea Gherzan <mgherzan@gmail.com>
Date: Wed, 14 Nov 2012 00:00:36 +0100

> Am 08.11.2012 02:31, schrieb Daniel Borkmann:
>> This patch is a follow-up for patch "net: filter: add vlan tag access"
>> to support the new VLAN_TAG/VLAN_TAG_PRESENT accessors in BPF JIT.
>> 
>> Signed-off-by: Daniel Borkmann <daniel.borkmann@tik.ee.ethz.ch>
 ...
> Acked-by: Mircea Gherzan <mgherzan@gmail.com>

Applied, thanks again.
