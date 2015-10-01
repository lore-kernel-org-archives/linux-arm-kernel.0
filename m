From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2015 20:10:41 +0100
Subject: [PATCH] arm: perf: Fix userspace call stack walking
In-Reply-To: <20151001172643.GA23147@dreric01-gentoo.localdomain>
References: <20151001172643.GA23147@dreric01-gentoo.localdomain>
Message-ID: <20151001191041.GY21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 10:26:47AM -0700, Drew Richardson wrote:
> The layout of stack frames has changed over time. Testing using a
> arm-linux-gnueabi gcc-4.2 from 2007 the original code didn't work but
> this new code does. It also works with clang as well as newer versions
> of gcc.

Can you point to a modern ARM distribution where perf actually works with
calltraces into userspace?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
