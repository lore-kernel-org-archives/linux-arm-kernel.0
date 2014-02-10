From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 10 Feb 2014 12:22:14 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: Correct SYS DMAC clock defines
In-Reply-To: <1391646301-20197-1-git-send-email-horms+renesas@verge.net.au>
References: <1391646301-20197-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <52F8C476.7070607@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 00:25, Simon Horman wrote:
> This brings the implementation into line with the documentation.
>
> This problem was introduced when SYS DMAC clock defines were added by
> ac991dce6498b5fc ("ARM: shmobile: r8a7790: Add clock index macros for DT
> sources") in v3.13-rc2. I do not believe this results in any problems as
> these defines do not appear to be used anywhere yet.
>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>

I agree, although I have yet to get the DMA working.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
