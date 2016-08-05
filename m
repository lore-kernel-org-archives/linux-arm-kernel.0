From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 5 Aug 2016 09:00:30 +0200
Subject: [PATCH] arm64: Add workaround for Cavium erratum 26026
In-Reply-To: <57A3B660.4040309@gmail.com>
References: <1470302117-32296-1-git-send-email-mbrugger@suse.com>
 <20160804205707.GJ2151@rric.localdomain>
 <57A3B660.4040309@gmail.com>
Message-ID: <20160805070030.GQ22012@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.08.16 14:40:48, David Daney wrote:
> On 08/04/2016 01:57 PM, Robert Richter wrote:
> >The patch below is on top of Matthias' patch series:
> >
> >  arm64: Implement IPI based TLB invalidation
> >
> >The series is used to enable a workaround for Cavium ThunderX pass 1.x
> >systems.
> 
> 
> Where are the rest of the patches in the series?  I would have expected
> something like "[PATCH 1/X] arm64:..." with X being greater than one.

You are cc'ed here too:

 https://lkml.org/lkml/2016/8/4/101

-Robert
