From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 09:13:32 +0200
Subject: [RFC PATCH] ARM: sched_clock: allow sched_clock to be selected
	at runtime
In-Reply-To: <4E41A4A4.80000@gmail.com>
References: <1312910015-20043-1-git-send-email-marc.zyngier@arm.com>
	<4E41A4A4.80000@gmail.com>
Message-ID: <4E422F9C.4080409@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2011 11:20 PM, Rob Herring wrote:
>
> There are similar patchsets that move sched_clock into clocksource code.
> That seems like a cleaner approach to me.
>
> http://thread.gmane.org/gmane.linux.kernel/844872
>
> http://www.spinics.net/lists/arm-kernel/msg122716.html
>    

It's been tried like three times before, and never survived
testing in -next. Marc's patchset is less invasive and
it makes things better, not worse. So let's take this
stepwise, beginning with Marc's stuff.

Yours,
Linus Walleij
