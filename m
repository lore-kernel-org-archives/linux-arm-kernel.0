From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Oct 2012 04:45:07 +0000
Subject: arm-soc tree was Re: [PATCH] Fix socfpga compilation with
 early_printk() enabled
In-Reply-To: <20121028230153.GA8284@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201210271539.20156.arnd@arndb.de> <20121028230153.GA8284@elf.ucw.cz>
Message-ID: <201210290445.07535.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 October 2012, Pavel Machek wrote:
> > You can both send patches, we just need to know what to expect. For most
> > platforms it works best if one person collects the patches from
> > everyone.
> 
> > If you are sending patches with both Dinh and us as the recipients,
> > just make it clear who you want to pick up the patch.
> 
> Thanks. Would "[PATCH for soc]" in subject line be suitable markup?
> 

That works for me, but if you are planning to send a lot of patches,
please consider grouping them together instead so you can send a git
pull request instead, or alternatively use a patch series with
an introductory mail to describe the series.

	Arnd
