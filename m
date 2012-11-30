From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Nov 2012 22:53:14 -0800
Subject: [GIT PULL 3/3] omap late multiplatform cleanup for v3.8 merge
 window
In-Reply-To: <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
References: <pull-1353978372-642963>
 <50b4120b.d088e50a.742e.ffffd3d3SMTPIN_ADDED_MISSING@mx.google.com>
Message-ID: <20121130065314.GB6899@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 05:06:12PM -0800, Tony Lindgren wrote:
> The following changes since commit 0f9cb211ba5db93d488fe6b154138231fdd0e22d:
> 
>   Merge tag 'v3.7-rc7' into next/cleanup (2012-11-25 21:34:34 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-multiplatform-v2-signed
> 
> for you to fetch changes up to 5ebb428d045ea9b908864547819786d5bcebad05:
> 
>   ARM: OMAP: Move plat-omap/dma-omap.h to include/linux/omap-dma.h (2012-11-26 13:19:23 -0800)

Tony,

Did you mean to base this branch on next/cleanup? We normally try to avoid
having vendor branches based on our common next/* branches, since it adds
dependencies that makes it hard to rebuild our branch if needed for some
reason.


-Olof
