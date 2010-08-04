From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 4 Aug 2010 17:35:09 +0530
Subject: Memory type used for ioremap
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E5E47F6@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
	<20100709141416.GI22845@n2100.arm.linux.org.uk>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E5E42A7@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C641DE6B@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E5E47F6@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641E31D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Pedanekar, Hemant
> Sent: Wednesday, August 04, 2010 5:31 PM
> To: Shilimkar, Santosh; Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: Memory type used for ioremap
> 
> Shilimkar, Santosh wrote:
> >> Pedanekar, Hemant wrote:
> >>> Russell King - ARM Linux wrote:
> >>>> On Fri, Jul 09, 2010 at 07:32:46PM +0530, Pedanekar,
> > Hemant wrote:
> >>>>> Catalin,
> >>>>

> Santosh,
> 
> Can you please point me to the patch series you mentioned? I will give it
> a
> try.
http://www.spinics.net/lists/arm-kernel/msg93218.html

> 
> Regarding read-back, the writes themselves are not successful as the
> peripheral
> has specific requirement for non-posted writes. So reading back after
> write
> Always returns old value.
> 
Are you sure about this behaviour? 
