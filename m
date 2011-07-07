From: jochen@scram.de (Jochen Friedrich)
Date: Thu, 07 Jul 2011 18:23:27 +0200
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <CAK5ve-JQhJxWOL=UiX9SUxa5Rw8VrANyd05nuRJbytoZRR+EzA@mail.gmail.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>	<1309955687-19365-17-git-send-email-bryan.wu@canonical.com>	<4E146B7C.7060607@scram.de>
	<CAK5ve-JQhJxWOL=UiX9SUxa5Rw8VrANyd05nuRJbytoZRR+EzA@mail.gmail.com>
Message-ID: <4E15DD7F.3050702@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

> This looks good and it's the right way to do that. We need gpiolib
> supporting firstly. How's status of your patchset, I guess you're
> trying to update it.

I've resubmitted it yesterday for another review. In parallel, I'll 
retest this on top of 3.0-rc5 on real hardware and ask Russell if it's 
OK to submit to his patch tracker.

Thanks,
Jochen
