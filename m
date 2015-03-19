From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Mar 2015 10:10:50 +0900
Subject: linux-next: manual merge of the slave-dma tree with the arm-soc
 tree
In-Reply-To: <20150318120347.21288162@canb.auug.org.au>
References: <20150318120347.21288162@canb.auug.org.au>
Message-ID: <20150319011048.GA14051@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 12:03:47PM +1100, Stephen Rothwell wrote:
> Hi Vinod,
> 
> Today's linux-next merge of the slave-dma tree got a conflict in
> arch/arm/mach-shmobile/board-mackerel.c between commit a521422ea4ae
> ("ARM: shmobile: mackerel: Remove Legacy C board code") from the
> arm-soc tree and commit c078c62a7528 ("mmc: sh_mobile_sdhi: remove
> sh_mobile_sdhi_info v2") from the slave-dma tree.
> 
> I fixed it up (the former removed the file, so I did that) and can
> carry the fix as necessary (no action is required).

Thanks Stephen,

my understanding is that the plan is to correct the file in Vinod's tree
even thought it is removed in mine. Your fix is correct from my point of view.
