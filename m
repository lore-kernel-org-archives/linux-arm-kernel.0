From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 10 Feb 2016 10:56:41 +0530
Subject: [PATCH v2 7/9] Staging: rts5208: rtsx_transport.c: Remove
 unnecessary parentheses
In-Reply-To: <1454981485-15686-8-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-8-git-send-email-shaun.ren@linux.com>
Message-ID: <20160210052641.GC27755@sudip-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 05:31:23PM -0800, Shaun Ren wrote:
> This patch removes all unnecessary parentheses found by checkpatch.pl.
> 
> Signed-off-by: Shaun Ren <shaun.ren@linux.com>

This will not apply anymore because of some other changes done by:
9a66d05d82db ("Staging: rts5208: fix check for dma mapping error")

regards
sudip
