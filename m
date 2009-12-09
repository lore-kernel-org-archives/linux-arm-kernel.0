From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 10 Dec 2009 01:07:27 +0530
Subject: [PATCH 1/6] OMAP4: Fix cpu detection
In-Reply-To: <74583B8642AB8841B30447520659FCA9DE4CF096@dnce01.ent.ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	<74583B8642AB8841B30447520659FCA9DE4CF096@dnce01.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A826C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Cousson, Benoit
> Sent: Thursday, December 10, 2009 1:04 AM
> To: Shilimkar, Santosh; tony at atomide.com
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; linux at arm.linux.org.uk
> Subject: RE: [PATCH 1/6] OMAP4: Fix cpu detection
> 
> Hi Santosh,
> 
> >From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> >owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> >
> >This patch fixes the OMAP4430 cpu detection. Since the omap ID
> >register is not fused in OMAP4430 ES1.0 silicon, identification is
> >done using ARM CPUID register.
> 
> I think that this description is not reflecting your current patch that does use the DEVICE_ID
> register.
Yes. The second version uses ID_CODE but the commit message still refers to the 1st one. Will fix
Commit message.
