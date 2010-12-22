From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Dec 2010 21:25:13 -0700 (MST)
Subject: [PATCH] OMAP4: clocks: add dummy clock for mailbox
In-Reply-To: <1290108000-16835-1-git-send-email-h-kanigeri2@ti.com>
References: <1290108000-16835-1-git-send-email-h-kanigeri2@ti.com>
Message-ID: <alpine.DEB.2.00.1012212121380.1446@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Nov 2010, Hari Kanigeri wrote:

> In omap4, there is no explicit configuration register to enable mailbox clocks.
> Defining dummy clock for mailbox clock module to keep the mailbox driver
> backward compatible with previous omaps.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>

Thanks, queued for 2.6.38 as part of the "clk_b_2.6.38" branch on 
git://git.pwsan.com/linux-2.6

This patch appears in the integration tree as part of tag 
'integration-2.6.38-20101221-011' at git://git.pwsan.com/linux-integration


- Paul
