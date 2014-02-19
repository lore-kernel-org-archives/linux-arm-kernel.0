From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Feb 2014 08:30:25 +0000
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140218233645.GP31892@mtj.dyndns.org>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
Message-ID: <20140219083025.GB10504@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: linux-ide at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Please consider basing it on top of Hans' refactored ahci_platform.
> 
>  http://www.spinics.net/lists/linux-ide/msg47628.html

Okay, looks reasonable. I'm happy to do the extra work.

Can I do this as a subsequent patch though? The current patch fits
neatly onto our internal stable kernel (currently v3.10). The added
work will require back-porting Hans' patch-set, which has not yet
reached Mainline.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
