From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Jun 2015 17:20:11 +0100
Subject: Regular oops on shutdown of KVM/ARM64 machines with VGA device
In-Reply-To: <CAL5wTH4H7DiE-Z-YHCs7mLRPoixOOxi=yMk-j8yC1np1m=9sYw@mail.gmail.com>
References: <CAL5wTH4MtybHBk22r593HmVX+2jqCDm4fb2MyT2L0TMkHrD7pg@mail.gmail.com>	<20150629100304.GB18931@leverpostej>	<55914033.5060008@arm.com>	<CAL5wTH7EUh0ciutXKs2s-4VjKnRM65QmrUQQiRdM=R+_VXi6DA@mail.gmail.com>	<559270D3.8030305@arm.com>
 <CAL5wTH4H7DiE-Z-YHCs7mLRPoixOOxi=yMk-j8yC1np1m=9sYw@mail.gmail.com>
Message-ID: <5592C1BB.9090106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/15 17:16, Dirk M?ller wrote:
> Hi Marc,
> 
>> Can try the following patch?
> 
> [..]
> 
> Thanks a lot for the quick patch, from a brief testing this seems to
> fix the issue (on a 4k kernel). I'll retest this in our original
> configuration (which was 64k) but so far I don't see a reason why it
> shouldn't fix the issue.

Awesome. Mind if I put your Tested-by on the patch?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
