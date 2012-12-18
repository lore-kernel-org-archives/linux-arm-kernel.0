From: lznuaa@gmail.com (Frank Li)
Date: Tue, 18 Dec 2012 16:51:35 +0800
Subject: [PATCH 4/4] FEC: Add time stamping code and a PTP hardware clock
In-Reply-To: <20121218070420.GA2946@netboy.at.omicron.at>
References: <1351657531-25989-1-git-send-email-Frank.Li@freescale.com>
 <20121217091345.GA753@pengutronix.de>
 <CAHrpEqTVuSR_-Tpdzb98=VJbg7grSFvSQ9xA6mPsHpGb7RvNCg@mail.gmail.com>
 <20121217151445.GA17907@S2101-09.ap.freescale.net>
 <20121217200232.GS26326@pengutronix.de>
 <20121218070420.GA2946@netboy.at.omicron.at>
Message-ID: <CAHrpEqRxJrZRjfmcN3a2Xd1QCF9oM=hoXhddSv6u4SPPoJha6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> might be an option, but given that this patch seems to have bypassed any
>> review I feel more like reverting it.
>
> Instead of reverting, I suggest finding a solution (Frank) to let the
> code work when it can work and to prevent it when it cannot. This
> could be kconfig, DT, or run time probing of silicon revisions, but I
> don't have access to this hardware, and so I can't really say how to
> fix it.

I am traveling in this week. I will try to find out the solution after
come back office
in next week. But quick solution is shawn's patch, which resolve mx3
and mx5 problem at least in short term.

>
> Just for the record, I did in fact review this patch, and I commented
> on exactly this point. Frank said we would address this point, and he
> did so. Not knowing the imx family very well, I took his word for it.
> After all, Frank has a Freescale address, and I would expect a
> Freescale employee to know how to provide the right fix.
>
> Thanks,
> Richard
