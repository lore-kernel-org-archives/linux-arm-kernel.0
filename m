From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 12:59:19 +0800
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <5264A06B.2040202@mentor.com>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
 <5264A06B.2040202@mentor.com>
Message-ID: <20131021045917.GH17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 08:32:59PM -0700, jiada wrote:
> the difference between successful "echo b > /proc/sysrq-trigger"
> reboot and the failure one is:
> whether CPU0 is firstly stopped or not

Do you have commit a985941 (kernel/sys.c: call disable_nonboot_cpus() in
kernel_restart()) on your 3.5 kernel.  The commit can be found on 3.5.7
kernel.

Shawn
