From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 2 Aug 2010 18:51:50 +0530
Subject: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
In-Reply-To: <20100802131246.GM12293@atomide.com>
References: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
	<20100802131246.GM12293@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641D502@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Monday, August 02, 2010 6:43 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100731 20:38]:
> > The machine_kexec() calls outer_disable which can crash on OMAP4
> > becasue of trustzone restrictions.
> >
> > This patch overrides the default l2x0_disable with a OMAP4
> > specific implementation taking care of trustzone
> 
> Do you need different handling on GP omaps compared to HS omaps?
> 
No. Same API works for both

Regards,
Santosh
