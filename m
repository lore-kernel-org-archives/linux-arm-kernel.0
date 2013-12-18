From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Dec 2013 18:20:39 +0100
Subject: [PATCH] watchdog: mach-moxart: add restart handler
In-Reply-To: <1387379883-16525-1-git-send-email-jonas.jensen@gmail.com>
References: <1387379883-16525-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201312181820.39639.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 December 2013, Jonas Jensen wrote:
> mach-moxart lacks a separate register for reset; as a workaround,
> add a function that can be hooked to arm_pm_restart.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
