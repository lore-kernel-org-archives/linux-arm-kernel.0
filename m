From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 25 Sep 2013 21:49:07 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <20130925204432.GW25647@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 25 Sep 2013 21:44:32 +0100")
References: <alpine.LFD.2.03.1309242158340.312@syhkavp.arg>
 <1380122586.1974.84@driftwood>
 <20130925204432.GW25647@n2100.arm.linux.org.uk>
Message-ID: <yw1x38oswrss.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Sep 25, 2013 at 10:23:06AM -0500, Rob Landley wrote:
>> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
>>> It could be as simple as making gas accept an extra argument for
>>> instructions like dsb and just ignoring it.
>>
>> So you prefer I come up with the reversion patches locally and _not_  
>> send them upstream?
>
> This is a silly attitude.  What you're effectively saying is that we
> are never allowed to use any future ARM instructions in any Linux
> kernel because that might break your precious assembler.
>
> I've got news for you.  We're *not* going to listen to that argument.
>
> END OF DISCUSSION (everything else is just a waste of time.)

I fully agree.

-- 
M?ns Rullg?rd
mans at mansr.com
