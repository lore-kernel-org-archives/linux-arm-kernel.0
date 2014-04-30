From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Apr 2014 10:45:09 +0900
Subject: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
In-Reply-To: <48241008.smQVDtv0CD@avalon>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
 <1986104.5bpNkKVN8D@avalon> <20140429214846.GA27566@verge.net.au>
 <48241008.smQVDtv0CD@avalon>
Message-ID: <20140430014508.GF24989@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:59:46AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 30 April 2014 06:48:50 Simon Horman wrote:
> > On Tue, Apr 29, 2014 at 03:44:46PM +0200, Laurent Pinchart wrote:
> > > On Monday 28 April 2014 16:07:49 Simon Horman wrote:
> 
> [snip]
> 
> > > > BTW, are you planning to make the above mentioned driver update
> > > > before or after re-posting enablement patches for Koelsch and/or Lager?
> > > > I ask because I would like to make such patches the basis for
> > > > a patch for Marzen.
> > > 
> > > I'll try to do so today, after my talk at the ELC :-)
> > 
> > I thought you might be a bit busy with ELC so I went
> > ahead and made my Marzen patches. Hopefully they aren't
> > too far away from what you have in mind for the Koelsch and Lager.
> 
> I was busy, but I've just sent the patches :-) Could you please test them ? If 
> no problem is found I'd like the SCI patch to go in before this series, to 
> avoid adding a dependency on sci_ick in the marzen DT.

Sure, will do.

As mentioned else where I'd prefer not do depend
on the SCI patch. But lets continue that discussion elsewhere.
