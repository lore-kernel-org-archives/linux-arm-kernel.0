From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 7 Nov 2011 15:30:05 -0700
Subject: [PATCH 2/3 RESEND] ARM: pxa: Add DT testing machine
In-Reply-To: <201111072306.43015.marek.vasut@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-3-git-send-email-marek.vasut@gmail.com>
 <4EB854BC.8020203@gmail.com>
 <201111072306.43015.marek.vasut@gmail.com>
Message-ID: <20111107223005.GF28491@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 11:06:42PM +0100, Marek Vasut wrote:
> > On 11/07/2011 03:31 PM, Marek Vasut wrote:
> > > I use the Voipac PXA270 board for PXA DT conversion. This board is a
> > > helper for the conversion to go smoothly and the testing to be easy.
> > > 
> > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > Cc: Rob Herring <robherring2@gmail.com>
> > > ---
> > > +	help
> > > +	  PXA Device Tree Machine.
> > > +	  This is to be a generic machine which probes all of it's drivers
> > > +	  using the Flattened Device Tree blob. This is work-in-progress
> > > +	  so don't expect much yet. We selected the Voipac PXA270 device
> > > +	  as a base device to test support along the way.
> > > +
> > > +	  NOTE: This platform is mutually exclusive with the original!
> > 
> > It shouldn't need to be.
> 
> I want it that way ... eventually, this will be renamed to PXA_DT, but not now.

Nah, do it now.  Aim high.  :-)

g.
