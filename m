From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Dec 2011 21:27:31 -0700 (MST)
Subject: [PATCH 3/7] HACK: omap: convert 44xx data to common struct clk
In-Reply-To: <1323835918-2371-4-git-send-email-mturquette@ti.com>
References: <1323835918-2371-1-git-send-email-mturquette@ti.com>
 <1323835918-2371-4-git-send-email-mturquette@ti.com>
Message-ID: <alpine.DEB.2.00.1112132125200.12046@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 13 Dec 2011, Mike Turquette wrote:

> omap_clk_get_by_name must die.

You do realize that it exists for a reason?  That hardware clock names 
don't have anything to do with the Linux device model?


- Paul
