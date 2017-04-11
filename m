From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 11 Apr 2017 22:36:36 +0400
Subject: [PATCH v7 resend 00/20] ILP32 for ARM64
In-Reply-To: <20170411113334.GA27857@e104818-lin.cambridge.arm.com>
References: <1488395968-14313-1-git-send-email-ynorov@caviumnetworks.com>
 <20170410194740.GA28503@yury-N73SV>
 <20170411113334.GA27857@e104818-lin.cambridge.arm.com>
Message-ID: <20170411183636.GB5091@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Also, the latest benchmarks I've seen were mostly for user space
> while I'm more concerned with the user-kernel interface
> (https://marc.info/?l=linux-arm-kernel&m=148690490713310&w=2).

> On the glibc testing side, have the regressions been identified/fixed?

I run LTP for testing the ABI and kernel, and there is no failures in
ltplite scenario. With glibc testsuite, there's only 3 failures
comparing to lp64. (Steve, fix me if something changed.) This is
slides on ilp32 from Linaro Connect, hope you'll find it useful.

https://docs.google.com/presentation/d/1TKZqgH0XJUgMMGkw2fJA3Lzr57slht1sGKYJVBJTNM4/edit?usp=sharing

Yury
