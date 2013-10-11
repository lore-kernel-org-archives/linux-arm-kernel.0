From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 11 Oct 2013 14:53:41 -0700
Subject: [PATCH 1/2] ARM: clps711x: Use linux/sched_clock.h
In-Reply-To: <1380829783-876-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Thu, 3 Oct 2013 12:49:42 -0700")
References: <1380829783-876-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <87bo2v8oey.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Stephen Boyd <sboyd@codeaurora.org> writes:

> The sched_clock.h include is under include/linux now.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

I applied both of these to next/cleanup.

Thanks,

Kevin
