From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 14:57:50 -0800
Subject: [PATCH] ARM: OMAP2+: add missing ARCH_HAS_OPP
In-Reply-To: <52E901B3.5070307@ti.com>
References: <1389816038-17363-1-git-send-email-nm@ti.com>
 <52E901B3.5070307@ti.com>
Message-ID: <20140213225749.GG28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140129 05:29]:
> Hi Tony,
> On 01/15/2014 02:00 PM, Nishanth Menon wrote:
> > OMAP5, DRA7, AM43xx all have OPPs. So select the same to allow SoC
> > only configuration boot to work with OPP.
> > 
> > Reported-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > 
> > For DRA7, depends on: https://patchwork.kernel.org/patch/3465411/
> 
> Considering that dependent patch is now on linus master,
> a gentle ping -> The patch does apply on latest linus master commit
> 0e47c969c65e213421450c31043353ebe3c67e0c

Thanks applying into omap-for-v3.14/fixes.

Tony
