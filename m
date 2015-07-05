From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 5 Jul 2015 23:50:23 +0200 (CEST)
Subject: [PATCH RFC 1/2] at91: make using irqs for clock handling optional
In-Reply-To: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
References: <1435937609-18623-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <alpine.DEB.2.11.1507052349000.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jul 2015, David Dueck wrote:

> Deactivating the use of interrupts here fixes a crash on early boot with
> RT-Preempt.

Again, you completely fail to explain WHAT the problem is and WHY you
think that your patch is a proper solution.

Thanks,

	tglx
