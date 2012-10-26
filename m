From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 26 Oct 2012 11:02:06 -0400
Subject: [PATCH V2 2/4] arm: mvebu: adding SATA support: dt binding for
 Armada 370/XP
In-Reply-To: <20121026165759.01df4489@skate>
References: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
 <1351254650-26861-3-git-send-email-gregory.clement@free-electrons.com>
 <20121026133154.GN18811@titan.lakedaemon.net>
 <20121026133446.GM21046@lunn.ch>
 <508A945C.4010006@free-electrons.com>
 <20121026135225.GO21046@lunn.ch> <20121026165759.01df4489@skate>
Message-ID: <20121026150206.GQ18811@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 04:57:59PM +0200, Thomas Petazzoni wrote:
> 
> On Fri, 26 Oct 2012 15:52:25 +0200, Andrew Lunn wrote:
> > > Now, about white spaces vs tab, I don't know what is the rule
> > > for .dts file.
> > 
> > I personally use tabs, but i don't see anything in the
> > Documentation/CodingStyle.
> > 
> > Maybe ask on the device tree mailing list?
> 
> Yes, it would be good to know and document what is the rule for .dts
> files, and possibly extend checkpatch to cover those special rules
> for .dts files.

until that is resolved, can we make this patch conform to what is in the
file currently?  Once the dt folks clarify, we can run through all the
dts's and submit one cleanup series.

If there are no other comments on this series, I'm fine taking it as is
and doing the fixup on my end.  No need to do a version bump just for
this.

thx,

Jason.
