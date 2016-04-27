From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Wed, 27 Apr 2016 09:36:54 +0900
Subject: [PATCH v5 0/4] Cleaning printk stuff in NMI context
In-Reply-To: <1461239325-22779-1-git-send-email-pmladek@suse.com>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
Message-ID: <20160427003654.GB4782@swordfish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (04/21/16 13:48), Petr Mladek wrote:
> v5 adds changes suggested by Sergey Senozhatsky. It should not longer
> conflict with his async printk patchset.

passes my tests. (apart from that cosmetic-nano-nit) the series
looks good to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
