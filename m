From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:37:47 +0000
Subject: [PATCH v3 12/31] arm64: Atomic operations
In-Reply-To: <1347035226-18649-13-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-13-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071937.47670.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> This patch introduces the atomic, mutex and futex operations. Many
> atomic operations use the load-acquire and store-release operations
> which imply barriers, avoiding the need for explicit DMB.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
