From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 10:50:45 -0700
Subject: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <c048044c10b5712e25d190a0ae1dfee3155f81f7.1350327325.git.richardcochran@gmail.com>
References: <cover.1350327320.git.richardcochran@gmail.com>
 <c048044c10b5712e25d190a0ae1dfee3155f81f7.1350327325.git.richardcochran@gmail.com>
Message-ID: <20121016175045.GW15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Richard Cochran <richardcochran@gmail.com> [121015 12:23]:
> From: Mugunthan V N <mugunthanvnm@ti.com>
> 
> This patch adds minimal hwmod support for davinci mdio driver. This patch
> requires rework on parent child relation between cpsw and davinci mdio
> hwmod data to support runtime PM.

Looks like Paul Walmsley may have missed this one, maybe please resend
with him and linux-omap cc:d.

Regards,

Tony
