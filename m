From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 2 Mar 2016 03:30:10 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: Use srst_udelay for USB on dm814x
In-Reply-To: <1456883702-32377-1-git-send-email-tony@atomide.com>
References: <1456883702-32377-1-git-send-email-tony@atomide.com>
Message-ID: <alpine.DEB.2.02.1603020329440.8658@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2016, Tony Lindgren wrote:

> Without this booting t410 can fail randomly with no output
> depending on the .config options chosen. Enabling debug_ll
> causes the problem to go away. I narrowed this down to USB
> by disabling one module at a time.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Wow, nice.  Bet that was a pain!

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
