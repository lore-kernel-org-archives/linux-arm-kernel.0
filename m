From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Aug 2013 02:49:46 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130802223247.GC28831@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
 <20130802142010.GC7533@kroah.com>
 <20130802160932.GG5292@mudshark.cambridge.arm.com>
 <20130802223247.GC28831@kroah.com>
Message-ID: <20130807014945.GG15579@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 02, 2013 at 11:32:47PM +0100, Greg KH wrote:
> On Fri, Aug 02, 2013 at 05:09:32PM +0100, Will Deacon wrote:
> > I would anticipate most of these drivers going through the arm-soc tree, so
> > Olof and Kevin would be doing the yelling. You could join in the chorus too!
> > 
> > We basically need reviewers to adopt the position that a new bus should be
> > considered and dismissed before using the platform_bus, then you can yell
> > transitively through them.
> 
> I don't scale if I'm forced to review every driver to ensure that they
> shouldn't be using platform device and should be creating their own bus
> type.  You can do that, along with the other ARM developers reviewing
> these new subsystems and code being added.

Of course, I wasn't suggesting that you have to take the frontline for this
(quite the opposite in fact). Once the usual ARM reviewers know which line
to tow, it will start to be enforced by the ARM subtrees automatically.

Cheers,

Will
