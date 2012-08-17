From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:36:59 -0700
Subject: [PATCH v2 00/31] AArch64 Linux kernel port
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817093659.GU11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 10:54]:
> This is the 2nd version of the set of patches implementing Linux kernel
> support for the 64-bit ARM architecture (AArch64). Thanks to all who
> provided feedback on the previous version.

I've looked at these patches mostly from supporting SoCs point of view
and made few minor comments. It's nice to see that at least so far I did
not spot mutually exlusive #ifdef else stuff that's been causing major issues
supporting multiple SoCs with the current ARMs :) So all these patches,
feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
