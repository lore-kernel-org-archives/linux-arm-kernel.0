From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 3 Sep 2013 18:14:28 +0200
Subject: Unhandled prefetch abort on mirabox with 3.11-rc7
In-Reply-To: <52260977.9090103@leahnim.org>
References: <52253229.2050103@leahnim.org>
 <20130903104817.GE19598@titan.lakedaemon.net>
 <20130903155537.GI6617@n2100.arm.linux.org.uk>
 <52260977.9090103@leahnim.org>
Message-ID: <20130903181428.150556af@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jochen De Smet,

On Tue, 03 Sep 2013 12:08:23 -0400, Jochen De Smet wrote:

> >>> Keep on posting the oopses though, there may be a pattern to them.
> Another clue in the heat direction might be that with the rain the last 
> few days things seem
> at least a bit better, though it's probably too early to draw 
> conclusions.  First box's been up
> for 2 days 10 hours now, and the with this oops above 18 hours.

Sorry if those questions have already been posted in the previous
thread. What kind of tests / workload are you running on your Mirabox
to trigger the crash? I might be able to get one or two Mirabox running
here, so I could see if the problem is reproducible.

Also, is this something you're seeing only since 3.11-rc7 ? Is the
kernel originally provided with the Mirabox more stable ? Are earlier
kernel versions (such as 3.10 or earlier) more stable ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
