From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jan 2012 16:16:38 -0800
Subject: [PATCH] ARM: OMAP: fix MMC2 loopback clock handling
In-Reply-To: <4F0EFAC1.2080003@compulab.co.il>
References: <1326378405-27632-1-git-send-email-notasas@gmail.com>
 <4F0EFAC1.2080003@compulab.co.il>
Message-ID: <20120127001638.GF29812@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120112 06:50]:
> On 01/12/12 16:26, Grazvydas Ignotas wrote:
> > Currently MMC2 setup code can only enable loopback clock and
> > relies on reset value for boards that need to have it disabled.
> > This causes a problem with certain bootloaders that always enable
> > that clock, resulting with unwanted bootloader dependencies.
> > 
> > Fix this by making it disable the clock if board data says so.
> > 
> > Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks applying into fixes.

Tony
