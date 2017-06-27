From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 27 Jun 2017 14:05:55 +0200
Subject: [PATCHv5] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <20170517160530.GB18716@e104818-lin.cambridge.arm.com>
References: <1494944285-12152-1-git-send-email-mark.rutland@arm.com>
 <20170517160530.GB18716@e104818-lin.cambridge.arm.com>
Message-ID: <20170627120555.dwcrd52dfstookmh@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-17 17:05:31 [+0100], Catalin Marinas wrote:
> > Catalin, can you take this as a fix for v4.12?
> 
> I queued it for 4.12-rc2. Thanks.

I backported a few patches into v4.11-RT and the backtrace popped up
(which is fixed by this patch). The problem existed before it has been
made visible. Do you intend to push this patch stable?

Sebastian
