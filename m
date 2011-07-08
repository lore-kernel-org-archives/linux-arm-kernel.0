From: johnlinn@comcast.net (johnlinn at comcast.net)
Date: Fri, 8 Jul 2011 22:07:20 +0000 (UTC)
Subject: PL330 alignment requirement questions
In-Reply-To: <4E177EF2.9010900@gmail.com>
Message-ID: <732923838.379840.1310162840462.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 07/08/2011 04:56 PM, johnlinn at comcast.net wrote:
> > I'm testing our PL330 with the driver/dma/pl330 driver and see some
> > strangeness that's probably my own setup issue.
> >
> > I'm also using drivers/dmatest to test it with memory to memory
> > copies. I'm seeing that the copy alignment (copy_align) is not setup
> > (it's 0) such that I see errors on some transfers at the end of the
> > transfer.
> >
> > If I setup the copy_align to be 3 or larger then I don't see these
> > errors. This number doesn't make much sense to me and I'm digging
> > into the details (seems like 4 would make sense). I just wanted to
> > see if anyone had tested with dmatest and seen anything similar.
> >
> I ran this dmatest with Versatile Express and the example FPGA image
> from ARM with the PL330 and also saw errors. You've narrowed it down
> farther than I did and I don't have it setup currently.
> 
> Rob

Thanks Rob, appreciate the input.  Let's see if the Samsung guys have any input.
