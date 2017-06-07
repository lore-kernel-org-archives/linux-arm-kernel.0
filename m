From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 7 Jun 2017 17:23:20 +0800
Subject: [Question or BUG] [NUMA]: I feel puzzled at the function
 cpumask_of_node
Message-ID: <5937C608.7010905@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I executed numactl -H(print cpumask_of_node for each node), I got different result on X86 and ARM64.
For each numa node, the former only displayed online CPUs, and the latter displayed all possible CPUs.
Actually, all other ARCHs is the same to ARM64.

So, my question is: Which case(online or possible) should function cpumask_of_node be? Or there is no matter about it?

-- 
Thanks!
BestRegards
