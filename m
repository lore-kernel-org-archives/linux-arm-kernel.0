From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 26 Aug 2010 11:25:06 -0700
Subject: [PATCH 1/5] arm: mach-davinci: check irq2ctlr() result
In-Reply-To: <1279379947-15152-1-git-send-email-segooon@gmail.com> (Kulikov
	Vasiliy's message of "Sat, 17 Jul 2010 19:19:07 +0400")
References: <1279379947-15152-1-git-send-email-segooon@gmail.com>
Message-ID: <87wrrd2pvh.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kulikov Vasiliy <segooon@gmail.com> writes:

> If irq2ctlr() fails return IRQ_NONE.
> Also as it can fail make 'ctlr' signed.

[...]

> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>

Sorry for the lag on this one.

Queueing for 2.6.37 in linux-davinci.git

Kevin
