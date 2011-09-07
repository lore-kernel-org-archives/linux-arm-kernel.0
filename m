From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 7 Sep 2011 12:00:43 +0200 (CEST)
Subject: [PATCH 1/4] mach-integrator: retire some timer macros
In-Reply-To: <1315384233-27332-1-git-send-email-linus.walleij@stericsson.com>
References: <1315384233-27332-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.02.1109071200201.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Sep 2011, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> These macros are not used by anything since the switch to
> generic time in commit b9cedda230793cbf58eb012ddadedd490cc8e129
> so let's retire them.
> 
> Cc: Russell King <linux@arm.linux.org.uk>

 Acked-by: Thomas Gleixner <tglx@linutronix.de>
