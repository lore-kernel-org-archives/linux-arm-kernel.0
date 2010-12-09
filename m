From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 8 Dec 2010 17:00:21 -0700 (MST)
Subject: [PATCH 05/11] OMAP2+: clockdomains: split the clkdm hwsup
	enable/disable function
In-Reply-To: <871v5rg8px.fsf@deeprootsystems.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<20101208061838.30541.36426.stgit@twilight.localdomain>
	<871v5rg8px.fsf@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1012081659520.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Dec 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
>
> > - * _omap2_clkdm_set_hwsup - set the hwsup idle transition bit
> > +/**
> > + * _enable_hwsup - set the hwsup idle transition bit
> > + * @clkdm: struct clockdomain *
> > + *
> > + * XXX fix doco
> 
> hmm, 'doco' must be a new lingo I haven't learned yet.

Thanks, will fix these.


- Paul
