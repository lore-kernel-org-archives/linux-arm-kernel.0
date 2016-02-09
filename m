From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 9 Feb 2016 10:02:19 +0100
Subject: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
In-Reply-To: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160209090219.GA13035@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Yang Shi | 2016-02-08 14:49:24 [-0800]:

>BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917
?
>This issue is similar with 62c6c61("arm64: replace read_lock to rcu lock in
>call_break_hook"), but comes to single_step_handler.
>
>This also solves kgdbts boot test silent hang issue on 4.4 -rt kernel.

I am going to apply this for -RT.

Sebastian
