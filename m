From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Nov 2013 19:30:46 +0530
Subject: [PATCH] watchdog: davinci: rename platform driver to davinci-wdt
In-Reply-To: <1385559113-4354-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1385559113-4354-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <5295FB0E.4070406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 November 2013 07:01 PM, Ivan Khoronzhuk wrote:
> As we switch to use the watchdog core which permits more than one
> active watchdog in the system, rename platform driver to
> "davinci-wdt" to be identifiable.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Looks good to me. Since bulk of this patch touches mach-davinci, I would
like to take this through my tree to avoid conflicts with other
mach-davinci patches I accept.

Thanks,
Sekhar
