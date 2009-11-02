From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Nov 2009 11:00:08 +0000
Subject: Why flush_cache_all() not including flushing L2 cache if the
	system has L2 cache?
In-Reply-To: <4AEE44AD.4010604@gmail.com>
References: <4AEE44AD.4010604@gmail.com>
Message-ID: <20091102110007.GC1133@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 10:32:13AM +0800, Peter Chen wrote:
> I met a problem if the address is first used by cachable, then  
> uncachable. After that, the address will be filled with cachable value
> after that L2 cache line is evicted.

What _exactly_ are you trying to do?  Why are you apparantly mapping
something in as cacheable, and then making it uncacheable?
