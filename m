From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 19 Nov 2010 19:41:01 +0100
Subject: [PATCH] ARM: u300: ensure sched_clock() is notrace
In-Reply-To: <1290182785-22352-3-git-send-email-rabin@rab.in>
References: <1290182785-22352-3-git-send-email-rabin@rab.in>
Message-ID: <AANLkTi=0TvC2T1Q3M+TefEjPz344LsOHVpPdMa-vKSjk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/19 Rabin Vincent <rabin@rab.in>:

> Include sched.h to ensure sched_clock() has the notrace
> annotation, and mark any functions it calls as notrace
> too.

Looking good,
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
