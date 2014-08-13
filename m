From: hock.leong.kweh@intel.com (Kweh, Hock Leong)
Date: Wed, 13 Aug 2014 11:59:14 +0000
Subject: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support
 in PCI glue layer
In-Reply-To: <20140807084302.GO1657@lahna.fi.intel.com>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
 <20140725053230.GT1857@lahna.fi.intel.com>
 <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
 <20140729185529.GG17528@sirena.org.uk>
 <CAAQYJAtLVgqbs=n2gxyemDAoHhM=7PFJy9bqKUExTbC+1rSNMg@mail.gmail.com>
 <D004FADD.9F315%dvhart@linux.intel.com>
 <20140807084302.GO1657@lahna.fi.intel.com>
Message-ID: <F54AEECA5E2B9541821D670476DAE19C2B6D9010@PGSMSX102.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg at linux.intel.com]
> Sent: Thursday, August 07, 2014 4:43 PM
> To: Mark Brown; Darren Hart
> Cc: Andrea Adami; Chew, Chiau Ee; Kweh, Hock Leong; Russell King;
> chiauee85 at gmail.com; linux-kernel at vger.kernel.org; Haojian Zhuang; linux-
> spi at vger.kernel.org; Eric Miao; linux-arm-kernel
> Subject: Re: [PATCH v2] spi/pxa2xx-pci: Add common clock framework
> support in PCI glue layer
> 
> On Mon, Aug 04, 2014 at 08:55:50AM -0700, Darren Hart wrote:
> > On 7/29/14, 15:06, "Andrea Adami" <andrea.adami@gmail.com> wrote:
> >
> > >On Tue, Jul 29, 2014 at 8:55 PM, Mark Brown <broonie@kernel.org> wrote:
> > >> On Tue, Jul 29, 2014 at 06:13:06PM +0200, Andrea Adami wrote:
> > >>
> > >>> note that a previous version of the patch breaks spi on pxa machines:
> > >>> tested on pxa250 poodle and pxa255 corgi.
> > >>> The patch is included in linux-Yocto since 3.14.
> > >>
> > >> The interesting question is if this version works...
> > >
> > >Happy to report that I could finally test on poodle/pxa250 the
> > >current
> > >v2 and the patch doesn't seem to disturb the probe.
> > >Sorry for the noise.
> > >
> > >Andrea
> > >
> >
> > I tested this (v2) on the MinnowBoard-Max (Baytrail Atom E3825) in PCI
> > mode and successfully attached an MCP32XX ADC and tested it's IIO
> > interface.
> 
> Mark,
> 
> Any idea what happened to this patch? I didn't find it in linux-next and it
> looks like it is not merged with mainline either.

Hi Mark,

Would like to follow up with you about this patch. Do you have plan to merge it in ?


Regards,
Wilson
