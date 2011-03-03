From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 03 Mar 2011 19:12:25 +0100
Subject: [PATCH] ARM: mx51: Print silicon revision on boot
In-Reply-To: <20110303164427.GX29521@pengutronix.de> (Sascha Hauer's message
	of "Thu, 3 Mar 2011 17:44:27 +0100")
References: <1299114747-14091-1-git-send-email-festevam@gmail.com>
	<87lj0wwr0g.fsf@lebrac.rtp-net.org>
	<AANLkTinPvxKR0ppW5jKWSOw=x05w0tb6_d6x+e4ZWdan@mail.gmail.com>
	<20110303164427.GX29521@pengutronix.de>
Message-ID: <87d3m8vzsm.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

Hi,

> On Thu, Mar 03, 2011 at 12:43:14PM -0300, Fabio Estevam wrote:
>> Hi Arnaud,
>> 
>> On Thu, Mar 3, 2011 at 5:24 AM, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
>> > Fabio Estevam <festevam@gmail.com> writes:
>> > Hi,
>> >
>> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> >
>> > Why I like having boot log, I don't like have too verbose boot logs. If
>> > you add this, you have a good reason (I hope), but I can't know
>> > it. There's no patch description. So, please give a patch with proper
>> > explanation of why you need that. Anyway, having a proper patch
>> > description is imho always a good idea.
>> 
>> I think that printing the silicon version on boot is useful
>> information. Many issues are fixed in the latest silicon revision, so
>> while debugging mx51 issues it is good to know from the boot log if
>> someone is using the latest silicon version or not.
>
> +1
>
> There is less useful information in the bootlog than this. Also, there's
> the quiet option to not wait on the slow serial console.

You missed something in my mail. My point was not really about log
verbosity. There was *no* description at all. We both know that silicon
rev 2.0 has some nasty bugs like broken neon which has been fixed in rev
3.0 so it may be a good idea to print that but without proper
description, the aim may well have been "I want to print this because I
find it nice". I know it may be hard to write proper description but
here, it's not. I even got a good description as answer to my mail. I
should not had to ask for it.

Arnaud
