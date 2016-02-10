From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 22:19:51 +0100
Subject: [PATCH V2 03/12] dtb: amd: Fix DMA ranges in device tree
In-Reply-To: <56BBA80E.6090205@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2845776.WTPtnQzg8d@wuerfel> <56BBA80E.6090205@amd.com>
Message-ID: <5986200.Q9dxHf9bIM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 February 2016 04:13:50 Suravee Suthikulpanit wrote:
> 
> On 2/9/16 21:57, Arnd Bergmann wrote:
> > On Monday 08 February 2016 11:59:08 Suravee Suthikulpanit wrote:
> >> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >> Fix DMA ranges of smb0 and pcie0 nodes in AMD Seattle SOC.
> >>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >
> > This could use a changelog text to explain why it's broken and how the
> > fix works.
> >
> >       Arnd
> >
> 
> So, I have not experience the breakage. However, IIUC, the GICv2m MSI 
> frame is also considered DMA-able. So, I think it should be included in 
> the dma-range specified here. Please let me know if my assumption is 
> incorrect. Otherwise, I will include more description in the commit log 
> in my next rev.

No, I think this makes sense. Just put a more explanation into the changelog
when those things are not obvious from looking at the change.

	Arnd
