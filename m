From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 21 Sep 2016 14:17:05 -0400
Subject: ftrace function_graph causes system crash
In-Reply-To: <20160921171307.3fb84c87@xhacker>
References: <7d0e88fff8e64591ac31be3adbbf763c@SIWEX5A.sing.micron.com>
 <20160920100716.131d3647@gandalf.local.home>
 <0e38f79fdc1f4671943da74764c15050@SIWEX5A.sing.micron.com>
 <20160921171307.3fb84c87@xhacker>
Message-ID: <20160921141705.6ab0be03@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Sep 2016 17:13:07 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> I'm not sure whether the commit d6df3576e6b4 ("clocksource/drivers/arm_global_timer
> : Prevent ftrace recursion") can fix this issue.
> 
> this commit is merged since v4.3, I noticed your kernel version is v4.0

BTW, yes, that would be the fix.

-- Steve

> 
> Thanks,
> Jisheng
> 
> > Do you know now how to deeply debug and trace which line is wrong through Ftrace?
> > 
