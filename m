From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 26 Sep 2014 11:29:56 +0200 (CEST)
Subject: [PATCH v3 3/4] irq: Allow multiple clients to register for irq
 affinity notification
In-Reply-To: <7htx3vbfqr.fsf@deeprootsystems.com>
References: <1409170479-29955-1-git-send-email-lina.iyer@linaro.org>
 <1409170479-29955-4-git-send-email-lina.iyer@linaro.org>
 <alpine.DEB.2.10.1408272239190.3323@nanos>
 <20140902184305.GB91995@ilina-mac.local>
 <alpine.DEB.2.10.1409022109050.3333@nanos>
 <7htx3vbfqr.fsf@deeprootsystems.com>
Message-ID: <alpine.DEB.2.11.1409261129220.4567@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Sep 2014, Kevin Hilman wrote:
> Maybe I'm missing something, or maybe we're just lucky and nobody uses
> them together, but irq_set_affinity_notifier() only allows a single
> notifier to be registered at any given time.  So if you had a system

A single notifier per irq .....
