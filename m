From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Jun 2016 23:00:05 -0700
Subject: [PATCH] ARM: dts: am335x-boneblack: add i2c1 DT entry
In-Reply-To: <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC@SHSMSX101.ccr.corp.intel.com>
References: <1464853310-8738-1-git-send-email-yong.b.li@intel.com>
 <CAOCHtYib9YxckneM-j0Gk1YE=MnvAwAhvDjEDEuFJbH6W3EcWA@mail.gmail.com>
 <20160602173932.GF5995@atomide.com>
 <CAOCHtYiWYrwSidHnKv4siFT-wU=tt5-YeDTwbM022ZTxdPFYYA@mail.gmail.com>
 <20160602175635.GG5995@atomide.com>
 <BCE6BEBCDDF4B84E891D2320CBF96F1D3F9FB1EC@SHSMSX101.ccr.corp.intel.com>
Message-ID: <20160607060004.GD22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Li, Yong B <yong.b.li@intel.com> [160602 22:49]:
> Hi Tony,
> 
> I can submit a V2 version about the "disabled", or just drop this patch?

Probably best to wait on this one until we know how it can be
enabled without manually editing the dts file. I'm still hoping
u-boot could enable it based on some environment variable..

Regards,

Tony
