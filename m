From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 27 Jan 2010 12:35:23 +0100
Subject: [PATCH v1 1/1] Extended events (platform-specific) support in perf
In-Reply-To: <1264162139-26788-2-git-send-email-t.fujak@samsung.com>
References: <1264162139-26788-1-git-send-email-t.fujak@samsung.com>
	<1264162139-26788-2-git-send-email-t.fujak@samsung.com>
Message-ID: <1264592123.4283.2013.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-22 at 13:08 +0100, Tomasz Fujak wrote:

there's supposed to be a changelog here...

> Signed-off-by: Tomasz Fujak <t.fujak@samsung.com>
> Reviewed-by: Pawel Osciak <p.osciak@samsung.com>
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kuyngmin.park@samsung.com>

Surely one of you knew that ;-)

Anyway, I still think it stinks, and as pointed out, it violates the
one-value-per-file sysfs rule.

I really see no reason why you cannot do this in userspace, have
tools/perf/ provide a library that does this for all supported platforms
with a common interface or something.
