From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 18 May 2016 09:31:32 +0800
Subject: [PATCH v12 10/10] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <20160517102427.GD8104@sirena.org.uk>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-11-git-send-email-dave.long@linaro.org>
 <20160517095714.GA25167@sha-win-210.asiapac.arm.com>
 <20160517102427.GD8104@sirena.org.uk>
Message-ID: <20160518013131.GA29570@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 11:24:27AM +0100, Mark Brown wrote:
> On Tue, May 17, 2016 at 05:57:33PM +0800, Huang Shijie wrote:
> > On Wed, Apr 27, 2016 at 02:53:05PM -0400, David Long wrote:
> 
> > > +#ifdef CONFIG_ARM64
> > > +	pr_info("pre_handler: p->addr = 0x%p, pc = 0x%lx\n",
> 
> > I think you miss the KERN_INFO here.
> 
> That's what pr_info() does over printk() - it adds the KERN_INFO more
> cleanly.
sorry, I thought the "pr_info" to "printk" when I first read this code.

thanks
Huang Shijie
