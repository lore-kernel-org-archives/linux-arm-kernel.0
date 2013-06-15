From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 18:04:56 -0700
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: don't use external clock for
 SCIFs
In-Reply-To: <1371106854-25560-3-git-send-email-horms+renesas@verge.net.au>
References: <1371106854-25560-1-git-send-email-horms+renesas@verge.net.au>
 <1371106854-25560-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130615010456.GP18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 04:00:54PM +0900, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> This is an external component and may or may not be there, while the
> internal clock always works.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Looks like this one is appropriate for arm-soc merging, but I'll hold off
pulling this branch until the serial driver piece has been acked or dropped (to
be merged by Greg).


-Olof
