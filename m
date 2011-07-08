From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 8 Jul 2011 11:00:25 +0800
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <4E15DD7F.3050702@scram.de>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>
	<4E146B7C.7060607@scram.de>
	<CAK5ve-JQhJxWOL=UiX9SUxa5Rw8VrANyd05nuRJbytoZRR+EzA@mail.gmail.com>
	<4E15DD7F.3050702@scram.de>
Message-ID: <CAK5ve-JDHECKs8sPVxLP_K6kYyM+-wL2bXJ-w=R7qoZJdRbmNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 8, 2011 at 12:23 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Bryan,
>
>> This looks good and it's the right way to do that. We need gpiolib
>> supporting firstly. How's status of your patchset, I guess you're
>> trying to update it.
>
> I've resubmitted it yesterday for another review. In parallel, I'll retest
> this on top of 3.0-rc5 on real hardware and ask Russell if it's OK to submit
> to his patch tracker.
>

Great, I will remove my modification of simpad code in my patchset.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
