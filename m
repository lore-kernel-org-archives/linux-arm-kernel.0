From: amittomer25@gmail.com (Amit Tomer)
Date: Wed, 21 Oct 2015 21:07:04 +0530
Subject: [PATCH RFC] arm64/ftrace: Define a new arm64 trace clock source
 based on cntpct_el0 register.
In-Reply-To: <20151021094404.0e3114f9@gandalf.local.home>
References: <1445170639-13943-1-git-send-email-amittomer25@gmail.com>
 <20151021094404.0e3114f9@gandalf.local.home>
Message-ID: <CABHD4K_DmujOCEF=2R4ecJ7uH4yZ6QZAqBFFXpbGTh6i_xFqvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for looking into it and providing your comments.


>> +       [local] global counter x86-tsc arm64-pct
>
> You don't need to update this line. You can't have both x86-tsc and
> arm64-pct at the same time.

  Ok, I understand. But is there a nice way to put it, something like
x86-tsc/arm64-pct/... ?

> Why is this a define and not a static inline?

There is no specific reason to it . I would change it to static inline.

Thanks,
-Amit
