From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 30 Nov 2011 08:43:09 +0000
Subject: [PATCH] ARM: davinci: fix mach/gpio.h includes
In-Reply-To: <1322545839-30405-1-git-send-email-rachna@ti.com>
References: <1322545839-30405-1-git-send-email-rachna@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B603514F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rachna,

On Tue, Nov 29, 2011 at 11:20:39, Patil, Rachna wrote:
> This patch addresses Russell's comments at [1] by replacing the
> mach/gpio.h includes to linux/gpio.h for TI's DA830/OMAP-L137/AM17x and
> DA850/OMAP-L138/AM18x platforms.
> 
> [1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/126553
> 
> Signed-off-by: Patil, Rachna <rachna@ti.com>

To which baseline does this patch apply? It doesn't apply
to the master of the davinci tree. These mach/gpio.h includes
have been changed to mach/gpio-davinci.h in the v3.2 merge.

Thanks,
Sekhar
