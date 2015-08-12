From: long.wanglong@huawei.com (long.wanglong)
Date: Wed, 12 Aug 2015 11:14:23 +0800
Subject: How to support multiple watchpoints on kernel after 3.10 when using
 arm debug architectures prior to 7.1?
Message-ID: <55CABA0F.9020901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

The linux kernel after 3.10 (after the commit c512de95 "ARM:
hw_breakpoint: reserve one breakpoint for watchpoint stepping" )
reserve a single breakpoint, regardless of the number of watchpoints,
when the hardware use the ARM Debug architectures prior to 7.1.

On these older CPUS, how to support multiple watchpoints when
using kernel after 3.10?

Are there any risks if we change the function 'get_num_wrps(void)'
and force it returning the number of watchpoints the hardware have?

Best Regards
Wang Long
