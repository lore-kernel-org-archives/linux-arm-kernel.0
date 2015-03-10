From: fengguang.wu@intel.com (Fengguang Wu)
Date: Tue, 10 Mar 2015 11:41:39 +0800
Subject: [PATCH baohua] ASoC: sirf: atlas7: atlas7_iacc_dai_ops can be
 static
In-Reply-To: <20150205171159.GY21293@sirena.org.uk>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
 <20150205170352.GA49811@snb> <20150205171159.GY21293@sirena.org.uk>
Message-ID: <20150310034139.GA17221@wfg-t540p.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 05:11:59PM +0000, Mark Brown wrote:
> On Fri, Feb 06, 2015 at 01:03:52AM +0800, kbuild test robot wrote:
> > sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?
> 
> This file isn't in an upstream tree, should this patch have been sent
> upstream (I suspect non-upstream trees may need a bit of filtering in
> the scripts)?

Good point! I just added some tests trying to avoid this, which should
be much better, but nevertheless not complete enough to cover all cases.
Please help point out inadequate cases when you come across them in future!

Thanks,
Fengguang
