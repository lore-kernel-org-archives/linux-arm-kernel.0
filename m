From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 15 Jan 2014 13:50:20 +0000
Subject: [RFC 0/2] Early patches to get rid of meminfo
In-Reply-To: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
References: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140115135020.GJ30907@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Tue, Jan 14, 2014 at 09:55:20PM -0800, Laura Abbott wrote:
> With the move away from bootmem and the convergence on memblock, it seems
> like meminfo should be deprecated as well to avoid duplication. This is
> a first pass attempt to just use memblock and not have meminfo integrated.
> There is still a major issue in terms of actually specifying mem at location
> on the command line but I wanted to send this out for some early feedback
> before putting any more effort into this. I've done basic boot testing on
> a simple DT target.

I can't see 1/2 and 2/2 - either in my inbox or in the archive.
Could you resend?

/
    Leif
