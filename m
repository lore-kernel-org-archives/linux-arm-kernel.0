From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 14:54:03 +0900
Subject: [PATCH] ARM: shmobile: Move SYSC base variable to inside ifdefs
In-Reply-To: <20140224055212.1822.52295.sendpatchset@w520>
References: <20140224055212.1822.52295.sendpatchset@w520>
Message-ID: <20140226055357.GA6392@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 02:52:12PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Move the rcar_sysc_base variable to inside #ifdefs to avoid
> triggering build warnings in case PM or SMP is not selected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up.
