From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Mar 2010 15:56:40 -0800
Subject: [PATCH 12/19] omap: Fix gpio_resume_after_retention
In-Reply-To: <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
	<20100311234834.4500.12726.stgit@baageli.muru.com>
	<A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
Message-ID: <20100311235640.GW2900@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aguirre, Sergio <saaguirre@ti.com> [100311 15:47]:
> Hi Tony,
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Thursday, March 11, 2010 5:49 PM
> > To: linux-arm-kernel at lists.infradead.org
> > Cc: Aguirre, Sergio; linux-omap at vger.kernel.org
> > Subject: [PATCH 12/19] omap: Fix gpio_resume_after_retention
> > 
> > From: Tony Lindgren <Aguirre>
> 
> Something funky mix happened with the authorship here :)
> 
> Should be:
> 
> From: Sergio Aguirre <saaguirre@ti.com>

Thanks, updated patch below.

I think this issue is related to applying patches from
patchwork.kernel.org with email addresses in Lastname, Firstname
format..

Tony
