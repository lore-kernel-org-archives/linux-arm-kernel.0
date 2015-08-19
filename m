From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Aug 2015 10:13:06 +0100
Subject: [PATCH v2] arm64 Kconfig: Move LIST_POISON to a safe value
In-Reply-To: <1439927410-15522-1-git-send-email-jeffv@google.com>
References: <1439927410-15522-1-git-send-email-jeffv@google.com>
Message-ID: <20150819091306.GC21913@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 12:50:10PM -0700, Jeff Vander Stoep wrote:
> Move the poison pointer offset to 0xdead000000000000, a
> recognized value that is not mappable by user-space exploits.
> 
> Signed-off-by: Thierry Strudel <tstrudel@google.com>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
