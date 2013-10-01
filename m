From: marex@denx.de (Marek Vasut)
Date: Tue, 1 Oct 2013 06:14:39 +0200
Subject: [PATCH] ARM: mxs: stub out mxs_pm_init for !CONFIG_PM
In-Reply-To: <CAOMZO5AAPjtomrbzMN_+9C1gv1R5v8PCtP4bzynm1Ff_e7jcVg@mail.gmail.com>
References: <2964094.prhBouhISv@wuerfel> <201309300050.20047.marex@denx.de>
 <CAOMZO5AAPjtomrbzMN_+9C1gv1R5v8PCtP4bzynm1Ff_e7jcVg@mail.gmail.com>
Message-ID: <201310010614.39469.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Sun, Sep 29, 2013 at 7:50 PM, Marek Vasut <marex@denx.de> wrote:
> > Can you please pick this patch for 3.10 stable? It fixes a build issue on
> > i.MX23/i.MX28 in case CONFIG_PM is not enabled.
> > 
> > Patchwork link: http://patchwork.ozlabs.org/patch/253324/
> > 
> > Upstream GIT:
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arc
> > h/arm/mach- mxs/pm.h?id=7a9caf59f60e55a8caf96f856713bd0ef0cc25a7
> > 
> > Thank you!
> 
> Just send the patch following this document so that it can be included
> in stable:
> Documentation/stable_kernel_rules.txt

Fixed now (I hope). Thanks!

Best regards,
Marek Vasut
