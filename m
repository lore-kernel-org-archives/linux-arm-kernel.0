From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Aug 2012 11:44:23 +0100
Subject: LPAE for outer caches functiopns (was Re: [RFC 3/6] arm:
 cache-l2x0: add support for Aurora L2 cache ctrl)
In-Reply-To: <5025229A.2090007@free-electrons.com>
References: <20120808151946.GE4579@mudshark.cambridge.arm.com>
 <1344530925-25857-1-git-send-email-gregory.clement@free-electrons.com>
 <20120810144730.GG2066@mudshark.cambridge.arm.com>
 <5025229A.2090007@free-electrons.com>
Message-ID: <20120813104422.GB20537@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 04:02:50PM +0100, Gregory CLEMENT wrote:
> On 08/10/2012 04:47 PM, Will Deacon wrote:
> > On Thu, Aug 09, 2012 at 05:48:44PM +0100, Gregory CLEMENT wrote:
> >> You will find an updated version of this patch with LPAE support. I've
> >> tested with and without LPAE selected.
> 
> Just a rectification, in fact I managed to build in both case, and to run
> only without LPAE support. I didn't have the support for LPAE yet. I was
> surprised that it worked out of the box, but in fact I tested the wrong
> kernel! I realized this this morning.

Ok, please keep me updated with how you get on. I can't shake this nagging
feeling that the memory-mapped interface is restricted to 32-bit addresses,
which is why the XP has the option to treat the L2 as an inner-cache...

</speculation>

Will
