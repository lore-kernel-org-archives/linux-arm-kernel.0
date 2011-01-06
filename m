From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 6 Jan 2011 13:51:57 +0300
Subject: [PATCH v2 0/3] add CNS3xxx AHCI support
In-Reply-To: <AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
	<4D24B53C.4020009@pobox.com>
	<AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
Message-ID: <20110106105157.GA9560@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 02:43:08PM +0800, Lin Mac wrote:
[...]
> > It is overkill to rename the entirety of ahci_platform just for one override
> > function.
> > This sort of thing I would have expected to be added directly to
> > ahci_platform.c.
> It might be overkill for only one controller. but it is more clean and
> readable to have different SoC specific changes in separate files,
> especially when more SoCs need to make similar changes.

I think that renaming the file is not necessary. You can just
rename the module in the makefile.

Personally I like the current approach more than putting
controller-specific fixups directly into ahci_platform.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
