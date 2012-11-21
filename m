From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 12:08:01 +0000
Subject: [PATCH 331/493] ethernet: remove use of __devinitdata
In-Reply-To: <1353349642-3677-331-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-331-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121120801.GL3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is getting painful to review; why couldn't all the changes to one
set of drivers be grouped together?  I'm having to search out the same
drivers I'm responsible for many times in this patch set to do a review,
and it's getting extremely tiresome and probably becoming more probable
that I'll make a mistake.

So I'm going to stop sending acked-by's after this one.

Please consider the workload you put reviewers under next time, thanks.

On Mon, Nov 19, 2012 at 01:24:40PM -0500, Bill Pemberton wrote:
>  drivers/net/ethernet/i825xx/ether1.c              | 2 +-
>  drivers/net/ethernet/seeq/ether3.c                | 2 +-

Not sure if I missed couple are missing (etherh?  am79c961a?)...

But for these two,
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
