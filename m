From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Feb 2014 12:14:36 +0000
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <53049B7A.6080404@redhat.com>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <53049B7A.6080404@redhat.com>
Message-ID: <20140219121436.GE10504@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Cc: Tejun Heo <tj@kernel.org>
> >> Cc: linux-ide at vger.kernel.org
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Please consider basing it on top of Hans' refactored ahci_platform.
> > 
> >  http://www.spinics.net/lists/linux-ide/msg47628.html
> 
> Which reminds I must test the version I've rebased on top of 3.14-rc1
> and then send a v6 so that this can get merged.
> 
> Lee, I'll add you to the CC of the v6 I'm about to send.

Thanks Hans.

Once Tejun has accepted this driver I will go ahead and rebase on top
of your work and convert to the new API.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
