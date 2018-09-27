From: ak@linux.intel.com (Andi Kleen)
Date: Wed, 26 Sep 2018 20:00:35 -0700
Subject: perf segmentation fault from NULL dereference
In-Reply-To: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
Message-ID: <20180927030035.GF28040@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please me let me know if a valid issue so we can get a fix in.

If it crashes it must be a valid issue of course.

But I'm not sure about your bisect. Hard to see how my patch
could cause this. Sometimes bisects go wrong. 
You verified by just reverting the patch?

First thing I would also try is to run with valgrind or ASan and see if it
reports anything.

-Andi
