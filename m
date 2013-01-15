From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Jan 2013 12:29:22 -0500 (EST)
Subject: [RFC PATCH 0/4] b.L: Memory barriers and miscellaneous tidyups
In-Reply-To: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
References: <1358268498-8086-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.02.1301151228070.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jan 2013, Dave Martin wrote:

> After much head-scratching and discussion, I have concluded that we
> need comprehensive memory barriers in order to ensure that the
> low-level synchronisation code executes robustly on all platforms.
> 
> DSBs are excessive on most situations though, so many DSBs can be
> replces with DMBs.
> 
> As was observed in review, providing a C interface to the vlocks
> makes little sense, so this series gets rid of it.

Thanks.  I have already removed the C stuff in my version but I'll merge 
the rest no problem.


Nicolas
