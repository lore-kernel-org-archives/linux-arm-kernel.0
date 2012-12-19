From: josh.cartwright@ni.com (Josh Cartwright)
Date: Wed, 19 Dec 2012 13:04:12 -0600
Subject: [PATCH v2 0/7] Updates for Zynq's timer driver
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <20121219190412.GD1005@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 10:16:25AM -0800, Soren Brinkmann wrote:
> I started to put some effort on syncing the Xilinx Linux tree with mainline and
> the timer driver is my first victim.
> Most commits are fixing style issues or clean up. Functionality is touched only
> in patches #2 and #7.
> 
> Some patches are present in almost identically in the Xilinx Linux tree and I
> took over 'Acked-by' lines from those commits.
> 
> To repost the patch with the arm-kernel list included I made this a v2 to avoid
> confusion about which series is the current one, though the patches are the same
> as the ones posted before on lkml only.
> I added Josh's 'Reviewed-by' line though.

I had a chance this morning to get this set up and running on one of our
Zynq boards this morning in between testing Stephen's clk-zynq changes.
Looks good.

Whoever is going to pick this up (probably Michal), feel free to add my:

Tested-by: Josh Cartwright <josh.cartwright@ni.com>

Thanks,

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121219/6642571f/attachment.sig>
