From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 22 Dec 2011 17:34:27 -0000
Subject: [PATCH v2] ARM: net: JIT compiler for packet filters
In-Reply-To: <20111222170006.GA2321@localhost>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AF25@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In principle, the condition could be __LINUX_ARM_ARCH__ < 5, since the
> bx instruction is guaranteed to be available on all ARMv5 CPUs and
> later (ARMv5T is not required).

Can't this code look at the actual cpu being used, and
generate the relevant 'return' instruction?
(Instead of trying to use some compile-time value.)

	David
