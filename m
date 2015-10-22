From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 22 Oct 2015 16:43:16 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP4: hwmod data: Remove spinlock hwmod
 addrs
In-Reply-To: <1442263761-16757-2-git-send-email-s-anna@ti.com>
References: <1442263761-16757-1-git-send-email-s-anna@ti.com>
 <1442263761-16757-2-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.02.1510221643090.15693@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2015, Suman Anna wrote:

> The legacy-style device creation logic for hwspinlock
> has been removed after the DT-support was added to the
> driver. The hwmod addr space for spinlock is therefore
> no longer needed, so remove it.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Thanks, queued.


- Paul
