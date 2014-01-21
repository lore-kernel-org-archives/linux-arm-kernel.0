From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 21 Jan 2014 11:26:27 +0000
Subject: [RESEND][RFC PATCH 0/2] Early patches to get rid of meminfo
In-Reply-To: <1389813057-26572-1-git-send-email-lauraa@codeaurora.org>
References: <1389813057-26572-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140121112626.GN30907@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 11:10:55AM -0800, Laura Abbott wrote:
> With the move away from bootmem and the convergence on memblock, it seems
> like meminfo should be deprecated as well to avoid duplication. This is
> a first pass attempt to just use memblock and not have meminfo integrated.
> There is still a major issue in terms of actually specifying mem at location
> on the command line but I wanted to send this out for some early feedback
> before putting any more effort into this. I've done basic boot testing on
> a simple DT target.

Well, this set makes takes away most of the complexity of using the
UEFI memory map instead of DT for populating memblock.
I'm all for it.

/
    Leif
