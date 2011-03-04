From: khilman@ti.com (Kevin Hilman)
Date: Fri, 04 Mar 2011 13:42:34 -0800
Subject: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
	(Dave Martin's message of "Fri, 4 Mar 2011 18:16:13 +0000")
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
	<AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
	<7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
	<20110304174709.GB20560@atomide.com>
	<AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
Message-ID: <87r5amftpx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> writes:

> On Fri, Mar 4, 2011 at 5:47 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110304 09:36]:
>>> >
>>> > Following up on this, it looks like I have some locally-recorded
>>> > acks
>>> > which didn't make it into my posting ...
>>
>> To me looks like this is ready to go, but I'd like to see Kevin's
>> acks on this one as this touches the PM code.
>>
>> Or if Kevin wants to take the series, here's my ack for the series:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>

Yeah, I'll queue this series.

> Thanks -- I'll wait for Kevin to comment also.

I have to give one more round of sanity testing to this series, but
otherwise I have no outstanding issues.  I also need to coordinate with
Santosh on this because he has an additional cleanup series that touches
the same code.

Dave, just to confirm something The outstanding toolchain bugs only
affect compiling in Thumb-2 mode, right?  IOW, if I merge just this
series (without having the other toolchain workaround patches) we should
still be able to compile/run fine in ARM mode, correct?

Kevin
