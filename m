From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 25 May 2015 20:48:06 +0200 (CEST)
Subject: [PATCH] clockevents: don't suspend/resume if unused
In-Reply-To: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421399151-26800-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1505252046400.5457@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jan 2015, Alexandre Belloni wrote:

> There is no point in calling suspend/resume for unused
> clockevents as they are already stopped and disabled.
> 
> Furthermore, it can take some time to wait for some IPs to stop counting.

While I agree with the patch itself, I really can't understand that
last sentence.

If stuff is stopped and disabled, what takes time to stop counting?
 
Thanks,

	tglx
