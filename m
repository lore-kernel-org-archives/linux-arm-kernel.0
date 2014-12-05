From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Dec 2014 12:11:25 +0000
Subject: [PATCH v6 0/8] Introduce automatic DMA configuration for IOMMU
 masters
In-Reply-To: <CAOesGMg9BpL3AyDjuAvH_H5fOm-uga+_CZuJZ5p8zpHpJLg0qA@mail.gmail.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <CAOesGMg9BpL3AyDjuAvH_H5fOm-uga+_CZuJZ5p8zpHpJLg0qA@mail.gmail.com>
Message-ID: <20141205121125.GJ1630@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 07:12:24AM +0000, Olof Johansson wrote:
> On Mon, Dec 1, 2014 at 8:57 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Hello again,
> >
> > This is version 6 of the patches previously posted here:
> >
> >   RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
> >   RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
> >   RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
> >   RFCv4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302711.html
> >      v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307213.html
> >
> > The only change since v5 is the addition of acks from various maintainers.
> >
> > Now that the ARM bits have rmk's ack and the IOMMU bits have joro's ack,
> > I think this is good for merging via the arm-soc tree.
> >
> > Please let me know if a pull request would be preferable.
> 
> 
> Hi,
> 
> Yes, please collect the acks from the discussion in the last day or so
> and send a pull request (and include Robin's patch, obviously).

Sure, I'm just working out which of Robin's patches to take (if I don't hear
otherwise, it will be the one with Grant's ack on it).

Will
