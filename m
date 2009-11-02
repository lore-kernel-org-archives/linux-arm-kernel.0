From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 02 Nov 2009 10:32:13 +0800
Subject: Why flush_cache_all() not including flushing L2 cache if the system
	has L2 cache?
Message-ID: <4AEE44AD.4010604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear list,

I met a problem if the address is first used by cachable, then 
uncachable. After that, the address will be filled with cachable value
after that L2 cache line is evicted.

Thank you!

-- 
Best regards,
Peter Chen
