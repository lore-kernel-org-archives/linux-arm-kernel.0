From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 10 Dec 2010 18:36:00 -0700 (MST)
Subject: [PATCH 05/11] OMAP2+: clockdomains: split the clkdm hwsup
	enable/disable function
In-Reply-To: <alpine.DEB.2.00.1012081659520.13430@utopia.booyaka.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<20101208061838.30541.36426.stgit@twilight.localdomain>
	<871v5rg8px.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1012081659520.13430@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1012101832200.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Dec 2010, Paul Walmsley wrote:

> On Wed, 8 Dec 2010, Kevin Hilman wrote:
> 
> > Paul Walmsley <paul@pwsan.com> writes:
> >
> > > - * _omap2_clkdm_set_hwsup - set the hwsup idle transition bit
> > > +/**
> > > + * _enable_hwsup - set the hwsup idle transition bit
> > > + * @clkdm: struct clockdomain *
> > > + *
> > > + * XXX fix doco
> > 
> > hmm, 'doco' must be a new lingo I haven't learned yet.
> 
> Thanks, will fix these.

Here's the revised patch.


- Paul
