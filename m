From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 21 Nov 2013 15:10:27 -0800
Subject: [PATCH 00/17] Convert ARM sched_clock users to
 sched_clock_register()
In-Reply-To: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Fri, 15 Nov 2013 15:26:08 -0800")
References: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <87li0h8i70.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Stephen Boyd <sboyd@codeaurora.org> writes:

> Olof,
>
> Please consider picking up these simple conversion patches. They
> were sent a few months back[1] but I didn't keep pushing them due
> to the complex path to mainline that the core patches took. I've
> picked up the acks and resent. Now that the core kernel changes have
> landed in Linus' tree it's much easier to pull these changes in.

Just to clarify, are the dependencies in v3.12? or were they merged for
the v3.13 merge window and just recently it Linus' tree.

Kevin
