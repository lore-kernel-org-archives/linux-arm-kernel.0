From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 5 May 2015 20:09:27 +0800
Subject: [PATCH] serial/amba-pl011: fix minor bugs for pio mode
In-Reply-To: <20150505111155.GA16868@e103592.cambridge.arm.com>
References: <1430794825-14367-1-git-send-email-leo.yan@linaro.org>
 <20150505111155.GA16868@e103592.cambridge.arm.com>
Message-ID: <20150505120927.GB5513@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 12:11:56PM +0100, Dave P Martin wrote:
> On Tue, May 05, 2015 at 04:00:25AM +0100, Leo Yan wrote:
> [...]
> 
> Thanks for the fixes, but I already posted patches that probably fix the
> issues you are observing, And Greg took them into his tty-testing branch.
> 
> Can you give them a try instead of your patches?
> 
> Dave Martin (2):
>       Revert "serial/amba-pl011: Leave the TX IRQ alone when the UART is not open"
>       serial/amba-pl011: Refactor and simplify TX FIFO handling
> 
> from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> 
> 
> It would be good to have some feedback on them.

Tested w/t your two patches, it can fix issues quite well;
Also will back port them into local branch. Thanks u and Daniel
pointing out this.

Tested-by: Leo Yan <leo.yan@linaro.com>

Thanks,
Leo Yan
