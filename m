From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Jan 2013 09:07:39 -0800
Subject: [PATCH 3/3] ARM: omap2: use get_auxcr for aux ctrl register read
In-Reply-To: <50F7B6C0.5090102@ti.com>
References: <1358391205-23943-1-git-send-email-robherring2@gmail.com>
 <1358391205-23943-3-git-send-email-robherring2@gmail.com>
 <50F7B6C0.5090102@ti.com>
Message-ID: <20130117170738.GK14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130117 00:33]:
> On Thursday 17 January 2013 08:23 AM, Rob Herring wrote:
> >From: Rob Herring <rob.herring@calxeda.com>
> >
> >Use get_auxcr instead of inline assembly to read the CP15 aux ctrl
> >register.
> >
> >Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >Cc: Kevin Hilman <khilman@ti.com>
> >Cc: Tony Lindgren <tony@atomide.com>
> >---
> This patch and the rest of the series looks fine to me.
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

The series looks good to me too:

Acked-by: Tony Lindgren <tony@atomide.com> 
