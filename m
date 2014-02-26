From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Feb 2014 13:55:33 +0000
Subject: [PATCH v2 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140226135108.GC17302@htj.dyndns.org>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <1393328481-7251-3-git-send-email-lee.jones@linaro.org>
 <20140225144141.GA26788@htj.dyndns.org>
 <20140226135108.GC17302@htj.dyndns.org>
Message-ID: <20140226135533.GN9195@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: linux-ide at vger.kernel.org
> > > Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Applied to libata/for-3.15 w/ missing "\n" added to dev_err() in
> > st_ahci_suspend().
> 
> Reverted from libata/for-3.15 due to build failure.  Please drop
> ahci_platform_put_resource() calls.  ahci_platform now manages it
> through devres.

Ah, nice fixup.

I'll rebase onto your most recent tree and retest.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
