From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 25 Jul 2013 19:19:50 +0400
Subject: [PATCH v2 3/3] ARM: shmobile: marzen: Enable ARM_APPENDED_DTB
 in defconfig
In-Reply-To: <1374718423-24230-4-git-send-email-horms+renesas@verge.net.au>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
 <1374718423-24230-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51F14216.1010606@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-07-2013 6:13, Simon Horman wrote:

> "ARM: shmobile: marzen: Switch to DT_MACHINE_START" moves marzen
> over to use DT_MACHINE_START, however, the prevelant boot loader

    s/prevelant/prevalent/?

> does not support booting with a separate dtb. Thus, it makes
> sense to use ARM_APPENDED_DTB by default.

> This is consistent with other shmobile defconfigs.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

WBR, Sergei
