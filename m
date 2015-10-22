From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 22 Oct 2015 16:44:23 +0000 (UTC)
Subject: [PATCH 2/2] ARM: OMAP3: hwmod data: Remove legacy mailbox data
 and addrs
In-Reply-To: <1442273833-25013-3-git-send-email-s-anna@ti.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
 <1442273833-25013-3-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1510221644130.15693@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2015, Suman Anna wrote:

> Remove the mailbox attribute data, irq info and hwmod addr space
> data that are used for creating the legacy-style mailbox devices,
> there is no need for these as the support for legacy-mode for this
> IP is being dropped.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, queued.


- Paul
