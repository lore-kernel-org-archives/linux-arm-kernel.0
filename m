From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 13 Jun 2013 15:15:34 +0200 (CEST)
Subject: [PATCHv7 01/11] clockevents: Prefer CPU local devices over global
 devices
In-Reply-To: <51B991EF.70800@linaro.org>
References: <1370291642-13259-1-git-send-email-sboyd@codeaurora.org>
 <1370291642-13259-2-git-send-email-sboyd@codeaurora.org>
 <51B0A6E8.20909@linaro.org> <20130606180425.GQ599@codeaurora.org>
 <51B10D85.1060507@linaro.org> <20130606223848.GR599@codeaurora.org>
 <20130612214435.GE10823@codeaurora.org> <51B991EF.70800@linaro.org>
Message-ID: <alpine.LFD.2.02.1306131331430.22970@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Daniel Lezcano wrote:
> I prefer Thomas to have a look at it and ack it. I changed Cc to To for
> Thomas.

The patch does not apply on tip timers/core. The code has been
reworked a month ago. Please work against tip timers/core. That's
where this stuff ends up.

Thanks,

	tglx
