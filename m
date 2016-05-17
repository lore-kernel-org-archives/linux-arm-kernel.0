From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 May 2016 11:24:27 +0100
Subject: [PATCH v12 10/10] kprobes: Add arm64 case in kprobe example module
In-Reply-To: <20160517095714.GA25167@sha-win-210.asiapac.arm.com>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-11-git-send-email-dave.long@linaro.org>
 <20160517095714.GA25167@sha-win-210.asiapac.arm.com>
Message-ID: <20160517102427.GD8104@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 05:57:33PM +0800, Huang Shijie wrote:
> On Wed, Apr 27, 2016 at 02:53:05PM -0400, David Long wrote:

> > +#ifdef CONFIG_ARM64
> > +	pr_info("pre_handler: p->addr = 0x%p, pc = 0x%lx\n",

> I think you miss the KERN_INFO here.

That's what pr_info() does over printk() - it adds the KERN_INFO more
cleanly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160517/07f2ea4b/attachment.sig>
