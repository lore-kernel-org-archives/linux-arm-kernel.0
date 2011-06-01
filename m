From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Jun 2011 10:53:06 +0200
Subject: [PATCH 3/3] mach-u300: cleanup clockevent code
In-Reply-To: <alpine.LFD.2.02.1106011027360.3078@ionos>
References: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1105312319530.3078@ionos>
	<BANLkTi=UyypKZUQOCCL-KWyAbMQBKY4ccg@mail.gmail.com>
	<alpine.LFD.2.02.1106011027360.3078@ionos>
Message-ID: <BANLkTi=p_i0nsLWO_6Y06dw_UJyeo0ygxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/1 Thomas Gleixner <tglx@linutronix.de>:

> We need it even on UP for the &!^%$@ broadcast mechanism to avoid a
> massive ifdef mess there :(
>
> But yeah, we can make it conditional for SMP and simply set
> cpumask_of(0) in the UP case.

Like this?
