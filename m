From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 4 Sep 2010 14:31:39 +0530
Subject: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED instead
	of MT_DEVICE
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCA86A68@dbde02.ent.ti.com>
References: <1281262702-27732-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=9k19RUmfnNBO8AfFj_LtyNtsPPVYC_=-AW5yE@mail.gmail.com>
	<87hbih2gyv.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCA86A68@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7787@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Friday, August 27, 2010 10:17 AM
> To: Kevin Hilman
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> davinci-linux-open-source at linux.davincidsp.com
> Subject: RE: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED
> instead of MT_DEVICE
> 
> > -----Original Message-----
> > From: Kevin Hilman [mailto:khilman at deeprootsystems.com]
> > Sent: Friday, August 27, 2010 3:07 AM
> > To: Shilimkar, Santosh
> > Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > davinci-linux-open-source at linux.davincidsp.com
> > Subject: Re: [PATCH 3/3] davinci: Map sram using MT_MEMORY_NONCACHED
> > instead of MT_DEVICE
> >
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >
> > > On Sun, Aug 8, 2010 at 3:18 AM, Santosh Shilimkar
> > > <santosh.shilimkar@ti.com> wrote:
> > >> On Davinci SRAM is mapped as MT_DEVICE becasue of the section
> > >> mapping pre-requisite instead of intended MT_MEMORY_NONCACHED
> > >>
> > >> Since the section mapping limitation gets fixed with first
> > >> patch in this series, the MT_MEMORY_NONCACHED can be used now.
> > >>
> > >> Have not tested this, so somebody with Davinci hardware can
> > >> try this out
> > >>
> > >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > >> Cc: davinci-linux-open-source at linux.davincidsp.com
> > >> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > >
> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> >
> > Also, FYI... while not a very thorough test, I boot-tested this series
> > on DaVinci (dm355, omapl138) and it worked fine.
> >
> > I'll include in davinci git (in the davinci-testing branch) so it gets a
> > bit more testing.
> 
> Thanks a lot Kevin!!
> 
> Tony,
> Can you merge this in lo master as well. Actually I want all these
> 3 patches go together so that it doesn't break OMAP/DAVINCI.
> 
Ping


Regards,
Santosh
