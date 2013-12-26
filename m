From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 26 Dec 2013 04:13:31 +0000 (UTC)
Subject: [PATCH] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
In-Reply-To: <1386841969-765-1-git-send-email-rnayak@ti.com>
References: <1386841969-765-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1312260413190.15949@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Dec 2013, Rajendra Nayak wrote:

> With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
>  DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
> to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.
> 
> On DRA7 though, we seem to be missing this flag, and atleast on the DRA7 EVM
> where we use uart1 for console, boot fails with DEBUG_LL enabled.
> 
> Reported-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued with Lokesh's Tested-by.


- Paul
