From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Jun 2014 12:22:39 +0100
Subject: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM on
 the B2020 Rev-E
In-Reply-To: <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
 <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140619092042.GB26560@lee--X1>
 <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140619112239.GC26560@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Why are you only enabling this for rev-E board?
> > 
> > Purely for testing purposes, as it's the only board I have.  If
> > anyone has the other revisions and would be happy to test the driver
> > for me then great.
> 
> Ok that's what I suspected.
> 
> If you tell me how, I can test on a Rev C board. But as there are several other 
> revisions I think checking the board schematics would be the quickest way forward.

Great.  Do you have a oscilloscope/logic analyser?

> > > If you make the stih415 DT PWM nodes part of this series as well, then 
> > > assuming there is no good reason to the contary, the PWM could 
> > > be enabled for both stih415/6 in the common stih41x-b2020 DTS file which
> > > is also included by rev-E (assuming that PWM wiring is not some rev-E specific
> > > thing).
> 
> Can you add the stih415 bindings in V2 as well?

Who's using Orly1?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
