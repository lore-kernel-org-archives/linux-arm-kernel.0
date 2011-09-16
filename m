From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 Sep 2011 14:45:56 +0900
Subject: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
In-Reply-To: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
Message-ID: <20110916054556.GA10298@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 10:32:09PM -0700, Lei Wen wrote:
> This copy really don't need to do at the very second before the kernel
> would crash.
> 
> Signed-off-by: Lei Wen <leiwen@marvell.com>

This seems reasonable to me.

Acked-by: Simon Horman <horms@verge.net.au>
