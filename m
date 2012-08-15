From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 15:08:57 +0000
Subject: [PATCH v2 24/31] arm64: Add support for
 /proc/sys/debug/exception-trace
In-Reply-To: <1344966752-16102-25-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-25-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151508.57474.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> This patch allows setting of the show_unhandled_signals variable via
> /proc/sys/debug/exception-trace. The default value is currently 1
> showing unhandled user faults (undefined instructions, data aborts) and
> invalid signal stack frames.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
