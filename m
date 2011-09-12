From: joe@perches.com (Joe Perches)
Date: Mon, 12 Sep 2011 09:58:04 -0700
Subject: [PATCH 10/10] hwspinlock: add MAINTAINERS entries
In-Reply-To: <1315846025-11453-11-git-send-email-ohad@wizery.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
	<1315846025-11453-11-git-send-email-ohad@wizery.com>
Message-ID: <1315846684.31609.1.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-09-12 at 19:47 +0300, Ohad Ben-Cohen wrote:
> Update MAINTAINERS with entries for hwspinlock/core and hwspinlock/omap
> files.

trivial:

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -2953,6 +2953,14 @@ F:	Documentation/hw_random.txt
[]
> +HARDWARE SPINLOCK CORE
> +M:	Ohad Ben-Cohen <ohad@wizery.com>
> +S:	Maintained
> +F:	Documentation/hwspinlock.h

F:	Documentation/hwspinlock.txt

> +F:	drivers/hwspinlock/hwspinlock_core.c
> +F:	drivers/hwspinlock/hwspinlock_internal.h

Maybe
F:	drivers/hwspinlock/hwspinlock_*

> +F:	include/linux/hwspinlock.h
