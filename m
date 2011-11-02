From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 13:03:01 +0000
Subject: [PATCH] slub: doc: update the slabinfo.c file path
In-Reply-To: <1320231836-9555-4-git-send-email-jason.hui@linaro.org>
References: <1320231836-9555-1-git-send-email-jason.hui@linaro.org>
	<1320231836-9555-4-git-send-email-jason.hui@linaro.org>
Message-ID: <20111102130301.GD19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 07:03:54PM +0800, Jason Liu wrote:
> slabinfo.c has been moved from Documentaion/vm/ to
> tools/slub/ by commit:0d24db337e6d81c0c620ab65cc6947bd6553f742
> 
> Update the slub.txt doc to reflect this change too.
> 
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Christoph Lameter <cl@linux-foundation.org>

This patch shouldn't be part of this patch set; there is nothing IMX
specific with it.  It is purely a stand-alone bug fix and, therefore,
it should stand completely alone as its own patch.

You're not even copying it to those who you claim to be doing so in the
commit log above.

It should be copied to the appropriate people and mailing lists.
