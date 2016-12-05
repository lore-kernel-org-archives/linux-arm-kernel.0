From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Dec 2016 12:08:42 +0000
Subject: [PATCH] arm64: Add CMDLINE_EXTEND
In-Reply-To: <61060b44-64a9-d628-4faf-3a7ae06048aa@infradead.org>
References: <61060b44-64a9-d628-4faf-3a7ae06048aa@infradead.org>
Message-ID: <20161205120842.GA14429@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Fri, Dec 02, 2016 at 02:17:02PM -0800, Geoff Levand wrote:
> The device tree code already supports CMDLINE_EXTEND,
> so add the config option to make it available on arm64.

What's your use-case for this patch? Note that both CMDLINE_FORCE and
CMDLINE_EXTEND (if we introduce it) are ignored by the EFI stub.
However, we don't seem to have stated this anywhere.

-- 
Catalin
