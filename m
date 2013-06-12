From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:10:19 +0900
Subject: [PATCH] ARM: shmobile: Remove AP4EVB board support
In-Reply-To: <20130612091819.6024.76059.sendpatchset@w520>
References: <20130612091819.6024.76059.sendpatchset@w520>
Message-ID: <20130612141018.GZ32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 06:18:19PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove board support for the sh7372 based AP4EVB board
> 
> The sh7372 SoC support code is still kept around since it
> is in use by the Mackerel board which is basically a more
> recent board where the design is based on AP4EVB.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the (new) cleanup-boot branch
along with all its dependencies.
