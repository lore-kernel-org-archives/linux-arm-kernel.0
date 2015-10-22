From: amittomer25@gmail.com (Amit Tomer)
Date: Thu, 22 Oct 2015 20:33:57 +0530
Subject: [PATCH RFC] arm64/ftrace: Define a new arm64 trace clock source
 based on cntpct_el0 register.
In-Reply-To: <20151021115243.0d6d603f@gandalf.local.home>
References: <1445170639-13943-1-git-send-email-amittomer25@gmail.com>
 <20151021094404.0e3114f9@gandalf.local.home>
 <CABHD4K_DmujOCEF=2R4ecJ7uH4yZ6QZAqBFFXpbGTh6i_xFqvA@mail.gmail.com>
 <20151021115243.0d6d603f@gandalf.local.home>
Message-ID: <CABHD4K8D1zjBNWQO=eaCTtFO9GTW9WZwj8WPhmqjjX2Lzeoonw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> No, it's just an example. No need to update it.

   Ok, Thanks!

>> > Why is this a define and not a static inline?
>>
>> There is no specific reason to it . I would change it to static inline.
>
> Please do. static inline is preferred over defines. We only use defines
> when a static inline wont work for the needed operation.

Ok, Thanks!
