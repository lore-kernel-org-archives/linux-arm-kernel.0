From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Thu, 15 Sep 2016 17:09:06 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160915154736.GA19214@leverpostej>
References: <20160914173625.GB15356@leverpostej>
 <20160914180754.GA16053@kroah.com> <20160914182952.GA21615@kroah.com>
 <1473932133.10230.25.camel@nexus-software.ie>
 <20160915101330.GB6718@leverpostej>
 <1473935756.10230.42.camel@nexus-software.ie>
 <20160915112029.GC6718@leverpostej>
 <1473940088.10230.65.camel@nexus-software.ie>
 <20160915124601.GA9316@leverpostej>
 <1473954000.4035.5.camel@nexus-software.ie>
 <20160915154736.GA19214@leverpostej>
Message-ID: <1473955746.4035.23.camel@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-15 at 16:47 +0100, Mark Rutland wrote:
> On?
> I can't say this any more explicitly:
> 
> ****************************************************
> * The DT *cannot* know anything about get_cycles() *
> ****************************************************
> 
> It's no more complex than that.

Sure think Mark I understand your point.

I think to satisfy your objection the most sensible change to make is
using arch_timer_get_rate() compared to a desired rate of 19200000.

---
bod
