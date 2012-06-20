From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 13:07:04 +0800
Subject: [PATCH 1/1] pinctrl: pinctrl-mxs: fix a compiling error
In-Reply-To: <20120620052312.GA1568@S2100-06.ap.freescale.net>
References: <1340167717-13082-1-git-send-email-b29396@freescale.com>
 <20120620052312.GA1568@S2100-06.ap.freescale.net>
Message-ID: <20120620050703.GF10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:23:15PM +0800, Shawn Guo wrote:
> On Wed, Jun 20, 2012 at 12:48:37PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > The compiling error is:
> > drivers/pinctrl/pinctrl-mxs.c: In function 'mxs_dt_node_to_map':
> > drivers/pinctrl/pinctrl-mxs.c:140: error: implicit declaration of function 'free'
> > drivers/pinctrl/pinctrl-mxs.c:140: warning: incompatible implicit declaration of built-in function 'free'
> > It should be kfree.
> > 
> 
> Already fixed by Fabio.
> 
> http://git.kernel.org/?p=linux/kernel/git/linusw/linux-pinctrl.git;a=commit;h=14e1e9f5cadb7cff3a2846c27cc1b9c8f207ee18
> 
Sorry, missed it.

Regards
Dong Aisheng
