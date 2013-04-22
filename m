From: john.stultz@linaro.org (John Stultz)
Date: Mon, 22 Apr 2013 10:00:38 -0700
Subject: [PATCH 0/4] ARM 64 bit sched_clock take #2
In-Reply-To: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
References: <51709FD7.8050408@gmail.com>
 <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51756CB6.5060607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2013 05:29 PM, Stephen Boyd wrote:
> This is what I was thinking. I don't see why we can't move this to generic code and have arm64 use it too. Those patches will follow once I find an arm64
> compiler.

I think moving this to generic code sounds like a good idea. You could 
probably also prototype and test the 64bit code with x86_64, using the 
TSC counter.

thanks
-john
