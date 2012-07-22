From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 22 Jul 2012 15:50:13 +0200
Subject: [PATCH 1/7] stddev: make it selectable via Kconfig
In-Reply-To: <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120722130301.GI22657@game.jcrosoft.org>
 <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120722155013.417c9694@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sun, 22 Jul 2012 15:18:56 +0200,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :

> enable is by default for simple and hush
> we do not need to NO_SHELL
> 
> this allow to save 1KiB
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  commands/Makefile |    2 +-
>  common/Kconfig    |    5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)

Hum, I guess this should have been sent to the barebox@ mailing list,
rather than the linux-arm-kernel@ mailing list, no?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
