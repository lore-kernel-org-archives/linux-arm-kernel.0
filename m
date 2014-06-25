From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jun 2014 23:23:56 +0100
Subject: [PATCH 2/9] drivers: base: support cpu cache information
 interface to userspace via sysfs
In-Reply-To: <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140625222355.GK32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 06:30:37PM +0100, Sudeep Holla wrote:
> +		coherency_line_size: the minimum amount of data that gets transferred

So, what value to do envision this taking for a CPU where the cache
line size is 32 bytes, but each cache line has two dirty bits which
allow it to only evict either the upper or lower 16 bytes depending
on which are dirty?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
