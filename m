From: jochen.armkernel@leahnim.org (Jochen De Smet)
Date: Tue, 03 Sep 2013 12:08:23 -0400
Subject: Unhandled prefetch abort on mirabox with 3.11-rc7
In-Reply-To: <20130903155537.GI6617@n2100.arm.linux.org.uk>
References: <52253229.2050103@leahnim.org>
 <20130903104817.GE19598@titan.lakedaemon.net>
 <20130903155537.GI6617@n2100.arm.linux.org.uk>
Message-ID: <52260977.9090103@leahnim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2013 11:55, Russell King - ARM Linux wrote:
> On Tue, Sep 03, 2013 at 06:48:17AM -0400, Jason Cooper wrote:
>> Adding the relevant folks to the Cc: ...
> I don't think this is a kernel problem either.
I was afraid you were gonna say that  :/
>> On Mon, Sep 02, 2013 at 08:49:45PM -0400, Jochen De Smet wrote:
>>> [Not subscribed, so keep me on CC please]
>>>
>>> so, i'm afraid again, I don't think this is a kernel bug but pointing
>>> towards a hardware weakness.  The argument against that is you say that
>>> it's a different (your second) mirabox...  unless it's a generic design
>>> weakness.
Globalscale's somewhat infamous for heat issues with the Guruplug ; the 
mirabox is supposed
to not have the issue, and I don't immediately see any reports of it, 
but it wouldn't totally
surprise me.   The boxes are fairly hot to the touch (It won't burn your 
finger but it definitely
gets uncomfortable), and that's in a basement where the ambient temp 
probably never goes
above 75f.
>>> Keep on posting the oopses though, there may be a pattern to them.
Another clue in the heat direction might be that with the rain the last 
few days things seem
at least a bit better, though it's probably too early to draw 
conclusions.  First box's been up
for 2 days 10 hours now, and the with this oops above 18 hours.

Thanks for looking again.

J.
