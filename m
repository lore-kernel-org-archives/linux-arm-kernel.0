From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 26 Jul 2011 06:57:27 +0000 (UTC)
Subject: [PATCH 0/8] ARM: SAMSUNG: Add common PWM Backlight support
References: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
Message-ID: <j0logn$1bn$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 15 Jul 2011 20:12:40 +0530, Banajit Goswami wrote:

> The patches are created against "for-next" branch of Kukjin Kim's tree
> at:
>  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 
>  Patch [1/8]
>   -- add a common infrastructure to support PWM backlight for various
>      Samsung boards.

Why can't you use the drivers/video/backlight/pwm-bl.c ?

-- 
With best wishes
Dmitry
