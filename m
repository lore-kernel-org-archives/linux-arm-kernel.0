From: rachna@ti.com (Patil, Rachna)
Date: Wed, 30 Nov 2011 09:29:42 +0000
Subject: [PATCH] ARM: davinci: fix mach/gpio.h includes
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B603514F@DBDE01.ent.ti.com>
References: <1322545839-30405-1-git-send-email-rachna@ti.com>
 <DF0F476B391FA8409C78302C7BA518B603514F@DBDE01.ent.ti.com>
Message-ID: <4CE347531D4CA947960AF71FF095B93201799B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Wed, Nov 30, 2011 at 14:13:09, Nori, Sekhar wrote:
> Hi Rachna,
> 
> On Tue, Nov 29, 2011 at 11:20:39, Patil, Rachna wrote:
> > This patch addresses Russell's comments at [1] by replacing the 
> > mach/gpio.h includes to linux/gpio.h for TI's DA830/OMAP-L137/AM17x 
> > and DA850/OMAP-L138/AM18x platforms.
> > 
> > [1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/126553
> > 
> > Signed-off-by: Patil, Rachna <rachna@ti.com>
> 
> To which baseline does this patch apply? It doesn't apply to the master of the davinci tree. These mach/gpio.h includes have been changed to mach/gpio-davinci.h in the v3.2 merge.

My mistake. This patch applies on v3.1-davinci1 tag. I'll rework on the patch and repost.

> 
> Thanks,
> Sekhar
> 
> 
Regards,
Rachna
