From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 21 Jun 2012 11:56:13 +0200
Subject: [PATCH] ARM: zImage: Allow DTB command line concatenation with
 ATAG_CMDLINE
In-Reply-To: <7510940.OaXg6CbgK9@flexo>
References: <1340269017-11701-1-git-send-email-richard.genoud@gmail.com>
 <7510940.OaXg6CbgK9@flexo>
Message-ID: <CACQ1gAhsbv4QE-DjcYF1+YaVForG8TtQ=fjSBmBtXkUQxLYWLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/21 Florian Fainelli <florian@openwrt.org>:
> The only thing which is ARM-specific and not yet resolved is the following: if
> you have ARM_ATAG_DTB_COMPAT enabled, the kernel command-line contains only
> the bootloader supplied command-line and not bootloader + bootargs from DT. I
> have not yet had a chance to get this sorted.
That's the whole point of this patch : to have bootloader + bootargs
from DT when ARM_ATAG_DTB_COMPAT is enabled.

Richard.
