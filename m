From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 13 Jun 2012 15:25:58 -0700
Subject: [PATCH 01/14] rtc: ab8500-rtc: IRQF_ONESHOT when requesting a
 threaded IRQ
In-Reply-To: <4FD70481.6020207@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-2-git-send-email-lee.jones@linaro.org>
 <201206111531.20468.arnd@arndb.de> <4FD70481.6020207@linaro.org>
Message-ID: <20120613152558.e6025b04.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jun 2012 09:57:37 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.

What does this mean.  The kernel crashes?  The registration fails?  A
warning is emitted?

When fixing a bug, please fully describe the consequences of that bug.

> Cc: stable at vger.kernel.org

Especially when suggesting a -stable backport.
