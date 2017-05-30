From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 30 May 2017 19:02:21 +0100
Subject: [RFC PATCH v3 0/4] Simplify kernel-mode NEON
In-Reply-To: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
References: <1495736721-20985-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170530180219.GR3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 07:24:57PM +0100, Dave Martin wrote:
> This series aims to simplify kernel-mode NEON.

Hi Ard, do you have any further comments on this series?

I'd like to have it finalised as far as possible (modulo minor tweaks
and bugfixes) so that I can port the SVE patches on top of it.

Also, how do you think we should handle merging of this change?  There's
a flag-day issue here, since the kernel_mode_neon() API is being changed
in an incompatible way.

Cheers
---Dave

[...]
