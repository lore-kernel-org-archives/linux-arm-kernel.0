From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 May 2012 11:03:57 -0700
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120501170001.GB4089@opensource.wolfsonmicro.com>
References: <1335419936-10881-1-git-send-email-skannan@codeaurora.org>
 <4F98EB10.2000505@codeaurora.org> <20120426084201.GF17184@pengutronix.de>
 <4d67387a86d99cbb4e2acf68d3588b1c.squirrel@www.codeaurora.org>
 <20120426095135.GG17184@pengutronix.de> <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
 <20120501170001.GB4089@opensource.wolfsonmicro.com>
Message-ID: <4FA0258D.8020807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2012 10:00 AM, Mark Brown wrote:
> On Tue, May 01, 2012 at 11:13:34AM +0200, Andrew Lunn wrote:
>
>> I agree with you as well, it is frustrating. Could we agree, that once
>> this patch is in, we freeze the core until the start of the next
>> cycle. We use the remainder of this cycle for porting platforms to the
>> generic clock framework.
>
> Or merge the platforms then do framework changes incrementally, updating
> the platforms as we go (which is the normal pattern for maintaining a
> framework...).  I see we've already got SPEAr merged.

Sorry for the annoyance I seem to have caused. I too have been trying to 
get this in for a while before the other platforms started using the new 
framework. Not everyone was free at the same time and it's taken longer 
that I would have wished for.

I did my best to limit the changes that would be needed without making 
my patch useless. Appreciate your understanding.

Regards,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
