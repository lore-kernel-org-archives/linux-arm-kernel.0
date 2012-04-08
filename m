From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Sun, 8 Apr 2012 20:09:06 +0200
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
In-Reply-To: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <20120408180906.GA13348@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Fri 06 Apr 2012 18:02:29 +0200 or thereabout, Joachim Eastwood wrote:
> No AT91/AVR32 boards currently use at91_register_uart_fns so let's remove it.
> 
> The only other mach in the kernel that has a *_register_uart_fns function
> is SA1100 so the demand for this functionality is not great.

I agree with your statement, and I've never used this functionality. I'll
leave it to Nicolas to decide, AFAIK there are no AVR32 users of these
functions, if there are, they've never submitted any board code upstream.

> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
