From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Nov 2011 22:46:54 +0000
Subject: [PATCH v8 11/16] ARM: LPAE: Add fault handling support
In-Reply-To: <1320682618-1182-12-git-send-email-catalin.marinas@arm.com>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-12-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111110224654.GV12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 04:16:53PM +0000, Catalin Marinas wrote:
> The DFSR and IFSR register format is different when LPAE is enabled. In
> addition, DFSR and IFSR have similar definitions for the fault type.
> This modifies the fault code to correctly handle the new format.

I think this is also better than what we had.  Thanks for reworking
this.
