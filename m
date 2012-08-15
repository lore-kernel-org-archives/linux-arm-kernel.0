From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 16:13:57 +0000
Subject: [PATCH v2 13/31] arm64: Device specific operations
In-Reply-To: <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151613.57400.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> This patch adds several definitions for device communication, including
> I/O accessors and ioremap(). The __raw_* accessors are implemented as
> inline asm to avoid compiler generation of post-indexed accesses (less
> efficient to emulate in a virtualised environment).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>


Acked-by: Arnd Bergmann <arnd@arndb.de>
