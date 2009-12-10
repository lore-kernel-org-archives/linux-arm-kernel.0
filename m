From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 10:40:37 +0000
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <20091207221210.GI26821@n2100.arm.linux.org.uk>
References: <20091207221210.GI26821@n2100.arm.linux.org.uk>
Message-ID: <20091210104037.GC6207@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 10:12:10PM +0000, Russell King - ARM Linux wrote:
> While looking into the possible msync() issue (which turned out to be a
> non-issue - it's covered by clever code), I found that we're flushing
> the same page multiple times.

I'm going to queue this patch up today since I believe it is correct,
though it would be nice to have a few more people test it on pre-ARMv6
hardware.
