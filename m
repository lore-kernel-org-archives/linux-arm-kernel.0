From: david@gibson.dropbear.id.au (David Gibson)
Date: Fri, 10 Feb 2012 12:25:38 +1100
Subject: hex number case in dts files.
In-Reply-To: <20120210002950.GA18408@codeaurora.org>
References: <20120209180411.GA5654@codeaurora.org> <4F340E71.7070004@gmail.com>
 <20120210001921.GA10536@truffala.fritz.box>
 <20120210002950.GA18408@codeaurora.org>
Message-ID: <20120210012538.GC10536@truffala.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 04:29:50PM -0800, David Brown wrote:
> On Fri, Feb 10, 2012 at 11:19:21AM +1100, David Gibson wrote:
> > On Thu, Feb 09, 2012 at 12:20:33PM -0600, Rob Herring wrote:
> > > On 02/09/2012 12:04 PM, David Brown wrote:
> > > > I've noticed an inconsistency in the case of letters in hex constants
> > > > in various dts files.  The ones that are actually numbers probably
> > > > don't really matter, the but the node names are case sensitive
> > > > strings, and in some sense do matter.
> > > > 
> > > > I ask because some people I've spoken with internally seem to have
> > > > strong opinions about what case hex constants should be, and it'd be
> > > > nice to be able to have some guideline about this.  Historically, I've
> > > > always seen DT hex values in lowercase.
> > > > 
> > > 
> > > Lower case should be used for dts files.
> > 
> > Yes, the node names should always have the hex done in lower case.  I
> > have plans to put more checks in for how reg is encoded into node
> > names, but just need to get time.
> 
> What about number of digits?  Should a register at 0x42 be
> node at 00000042 or node at 42?  Again, I'm seeing both.

node at 42

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
