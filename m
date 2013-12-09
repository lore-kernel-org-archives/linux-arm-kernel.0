From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Dec 2013 11:27:23 -0500
Subject: [PATCH v5 0/5] Update Davinci watchdog driver
In-Reply-To: <1386185970-14488-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1386185970-14488-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <52A5EF6B.6060700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wim,

On Wednesday 04 December 2013 02:39 PM, Ivan Khoronzhuk wrote:
> These patches are intended to update Davinci watchdog to use WDT core
> and reuse driver for keystone arch, because Keystone uses the similar
> IP like Davinci.
> 

[..]

> v4..v5:
> - watchdog: davinci: change driver to use WDT core
> 	switched off CONFIG_WATCHDOG_NOWAYOUT option
> 
Can you please apply the series to your watchdog tree ?
Do let me know if you want us to prepare a git branch
to pull from.

Regards,
Santosh
