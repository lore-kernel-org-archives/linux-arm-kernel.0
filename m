From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 27 Mar 2012 15:27:35 -0700
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <CAJOA=zOq=kYfZUEnnQT_D4w=Kpp5n7R=k9oOCrxF59P5W-nw-w@mail.gmail.com>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
 <20120320094031.GI3852@pengutronix.de>
 <20120320141811.GF32469@S2101-09.ap.freescale.net>
 <20120320181050.GN3852@pengutronix.de> <4F68E34A.70207@codeaurora.org>
 <20120320231242.GP3852@pengutronix.de>
 <CAJOA=zOGTW7OqACWgJQW6HSPLVev+apdNhv4vNXjHTcp=7N+uQ@mail.gmail.com>
 <4F694484.1030706@codeaurora.org> <4F714397.6080608@codeaurora.org>
 <CAJOA=zOq=kYfZUEnnQT_D4w=Kpp5n7R=k9oOCrxF59P5W-nw-w@mail.gmail.com>
Message-ID: <4F723ED7.7010800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2012 11:49 AM, Turquette, Mike wrote:
> On Mon, Mar 26, 2012 at 9:35 PM, Saravana Kannan<skannan@codeaurora.org>  wrote:
>> Mike,
>>
>> (*nudge*) (*nudge*)
>
> Hi Saravana,
>
> I spent some time mulling over the ideas this weekend and I agree that
> we have 3 types of data, so having the three structs makes some sense.
>   I'm checking this patch out more earnestly today.
>

Thanks Mike. The patch has a few things to clean up. I would be glad to 
send out a cleaned up patch once we have an approximate consensus on 
what to copy/not copy.

Thanks,
Saravana
