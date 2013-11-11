From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 11 Nov 2013 14:41:51 +0000
Subject: [PATCH v4] ARM: vexpress/TC2: Implement MCPM power_down_finish()
In-Reply-To: <20131111134030.GA2391@e103592.cambridge.arm.com>
References: <20131108185613.GF2602@localhost.localdomain>
 <1384160080.4495.2.camel@hornet>
 <20131111134030.GA2391@e103592.cambridge.arm.com>
Message-ID: <1384180911.4495.77.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-11-11 at 13:40 +0000, Dave P Martin wrote:
> On Mon, Nov 11, 2013 at 08:54:40AM +0000, Pawel Moll wrote:
> > On Fri, 2013-11-08 at 18:56 +0000, Dave Martin wrote:
> > > Hi Pawel, did you manage to take a look at this?
> > > 
> > > I want to have something in place here, otherwise there's a nice WARN_ON
> > > to look forward to in 3.13 :)
> > > 
> > > I don't think I've seen a response from you so far?
> > 
> > On Fri, 2013-11-01 at 12:21 +0000, Pawel Moll wrote:
> > > PS. I actually had a look at the patches after you reminded me last week
> > > (two weeks ago? ;-)
> > 
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> 
> Thanks
> 
> What's the best way to send this upstream?

Through arm-soc, I believe. Generally Nico was pulling this stuff into
his PM branch (except for the one case of me helping out with the SPC).

Nevertheless I'm happy to queue it if you want me to.

Cheers!

Pawe?
