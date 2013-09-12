From: bilhuang@nvidia.com (Bill Huang)
Date: Thu, 12 Sep 2013 03:35:08 -0700
Subject: [PATCH 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
In-Reply-To: <20130912101459.GG30013@tbergstrom-lnx.Nvidia.com>
References: <1378898355-31290-1-git-send-email-bilhuang@nvidia.com>
 <1378898355-31290-3-git-send-email-bilhuang@nvidia.com>
 <20130912101459.GG30013@tbergstrom-lnx.Nvidia.com>
Message-ID: <1378982108.2475.3.camel@bilhuang-vm1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 18:14 +0800, Peter De Schrijver wrote:
> On Wed, Sep 11, 2013 at 01:19:14PM +0200, Bill Huang wrote:
> 
> > +static inline int tegra_cpufreq_init(void)
> > +{
> > +       retrun EOPNOTSUPP;
> 
> This should be -EOPNOTSUPP at least. I think -EINVAL might be better.

Yeah thanks, I'll also fix the TYPO of return.
> 
> Cheers,
> 
> Peter.
