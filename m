From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Jul 2014 22:33:59 -0700
Subject: [GIT PULL] ARM: SPEAr13xx PCIe updates for v3.17
In-Reply-To: <20140719045804.GC20064@quad.lixom.net>
References: <CAKohpo=T3taZx8e39tenCRBNxCUr=7H2xG7Ng=e+YQXuuY9u8Q@mail.gmail.com>
 <20140719045804.GC20064@quad.lixom.net>
Message-ID: <20140719053359.GF20064@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 09:58:04PM -0700, Olof Johansson wrote:
> On Wed, Jul 16, 2014 at 02:33:03PM +0530, Viresh Kumar wrote:
> > Hi Olof/Arnd,
> > 
> > This is another attempt to merge SPEAr PCIe updates after olof
> > pointed out *enough* issues with initial PULL request:
> > 
> > https://lkml.org/lkml/2014/7/9/641
> > 
> > Last version was sent here: http://patchwork.ozlabs.org/patch/368479/
> > and all the nits pointed out by Kishon & Bjorn are fixed in this pull
> > request.
> > 
> > Apart from ARM specific changes, this updates drivers/{pci|phy}. Bjorn
> > advised to get complete series via arm-soc tree earlier:
> > 
> > http://www.spinics.net/lists/linux-pci/msg30271.html
> > 
> > Please let me know if I couldn't get it right this time.
> 
> Looks good. Thanks for following up on this and fixing up stuff.
> 
> > 
> > The following changes since commit 4c834452aad01531db949414f94f817a86348d59:
> > 
> >   Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git
> > spear/pcie-support-v10
> > 
> > for you to fetch changes up to f6e670a3b62d23722d04e801244a068755a45b7a:
> > 
> >   ARM: SPEAr13xx: Update defconfigs (2014-07-14 11:04:44 +0530)
> 
> Merged into next/drivers.
> 
> If anything, just one thing: you should consider using signed tags. :)

Also, there's a conflict with one of the fixes that were sent earlier.
It'd been nice to keep this based on the -rc that had that fix to avoid the
conflict. Please check the contents in our for-next.


-Olof
