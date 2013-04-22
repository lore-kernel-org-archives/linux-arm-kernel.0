From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 22 Apr 2013 15:26:06 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <CAOesGMhUTyPdNo=yaRqEv+Zhf7ga8e-R0asbnuje_LioWbqsgg@mail.gmail.com>
References: <20130419164636.0d2405ca5fd927f1ba31fe40@canb.auug.org.au>
 <CAOesGMhUTyPdNo=yaRqEv+Zhf7ga8e-R0asbnuje_LioWbqsgg@mail.gmail.com>
Message-ID: <20130422152606.5e4fb41a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Olof Johansson,

On Fri, 19 Apr 2013 07:01:28 -0700, Olof Johansson wrote:

> > After merging the arm-soc tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > powerpc64-linux-ld: cannot find drivers/pci/host/built-in.o: No
> > such file or directory
> >
> > Caused by commit 9ecbe03ae85b ("pci: infrastructure to add drivers
> > in drivers/pci/host").
> >
> > I have used the arm-soc tree from next-20130418 for today.
> 
> Sorry about that, I'll drop the branch that brought in the of_pci
> consolidation from our repo.

The build failure reported here is totally independent of the of_pci
consolidation work. It's caused by the commit pointed in this e-mail,
and it is independent from Andrew Murray's work on of_pci consolidation.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
