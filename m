From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 17 Jul 2015 12:01:11 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
References: <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
 <20150717104144.6588b2f7@gandalf.local.home>
 <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
 <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
Message-ID: <20150717120111.11787d4d@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 Jul 2015 00:34:21 +0900
Jungseok Lee <jungseoklee85@gmail.com> wrote:


> 
> The [RFC 1/3] patch used in my environment is shaped as follows.
> I leave the hunk for *only* clear synchronization. This is why I choose this format
> instead of reposting a patch. I hope it would help to track down this thread.

You could just add:

 Link: http://lkml.kernel.org/r/1436765375-7119-3-git-send-email-takahiro.akashi at linaro.org

to your change log, and that will point to this thread. That's what the
Link tag was made for.

> 
> Steve,
> 
> I think this is my best at this point.
> 

OK, I'll just wait for the others to give their ack.

-- Steve
