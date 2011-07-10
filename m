From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 9 Jul 2011 20:03:20 -0600 (MDT)
Subject: [PATCH v2 08/18] OMAP4: clock data: Rename clock flags from 443X
	to 44XX
In-Reply-To: <1309552901-8944-9-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-9-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107092000370.15984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Rename current 4430 definitions to 44XX in oder to make this file
> applicable for the next revision (OMAP4460).
> 
> Create new flags for 44XX. They will be extented when OMAP4460
> will be introduced.
> 
> Fix as well the clkdev indentation that were previously broken.
> 
> Replace a couple of spaces by tabs.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

I've dropped this patch because Tony has indicated he doesn't want to
merge rename patches like this.


- Paul
