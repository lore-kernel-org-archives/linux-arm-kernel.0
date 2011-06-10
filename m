From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Fri, 10 Jun 2011 10:54:10 +0200
Subject: [PATCHv2 0/3] clocksource: add db8500 PRCMU timer
In-Reply-To: <20110609215939.GI24424@n2100.arm.linux.org.uk>
References: <1307007271-1004-1-git-send-email-mattias.wallin@stericsson.com>
	<20110602094622.GS3660@n2100.arm.linux.org.uk>
	<4DE7637B.3060901@stericsson.com>
	<20110602110137.GU3660@n2100.arm.linux.org.uk>
	<4DE77D9A.6090301@stericsson.com> <4DE788B2.5060308@ti.com>
	<1307040455.11492.52.camel@work-vm>
	<4DEF7CA1.8080809@stericsson.com>
	<20110609215939.GI24424@n2100.arm.linux.org.uk>
Message-ID: <4DF1DBB2.4040501@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2011 11:59 PM, Russell King - ARM Linux wrote:
> No - I'd like you to check whether the patch I sent fixes your
> sched_clock problem across suspend/resume so that we can get that sorted
> for everyone, instead of coming up with platform specific fixes.  Then
> we can work out how to hook that into cpuidle so that it works properly
> there.

Ahh, I see your plan. I was focused on the cpuidle problem and your 
patch only addressed suspend/resume.
Anyway, now that I understand more what you are after I'll have a look 
at it and come back to you.
