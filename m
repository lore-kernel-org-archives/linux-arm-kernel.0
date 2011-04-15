From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Apr 2011 10:10:04 -0600
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110415155642.GO1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 9:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 15, 2011 at 09:12:39AM -0600, Grant Likely wrote:
>> For example, John Linn
>> has posted support for the new Xilinx ARM FPGA platform, has been
>> through several rounds of review, but now he fears that it will all be
>> rejected and he'll have to start over in 3 months.
>
> Well, what about my fear that we won't be able to get anything more
> past Linus if we submit another 60k lines of code during the next
> merge window?

Worst he can say is no.  He /knows/ we're trying to fix the problem.
He also knows that development doesn't stop, even in the midst of
consolidation work that is going to take a lot of time.

To mitigate the risk, how about a
not-ideal-but-should-be-merged-anyway branch that is sent to Linus
after all the core code and consolidation changes have been merged?
We should even describe to Linus why this branch exists and give him
the option to say no if he wants to.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
