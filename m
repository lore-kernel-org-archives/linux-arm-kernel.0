From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 12 Sep 2013 13:14:59 +0300
Subject: [PATCH 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
In-Reply-To: <1378898355-31290-3-git-send-email-bilhuang@nvidia.com>
References: <1378898355-31290-1-git-send-email-bilhuang@nvidia.com>
 <1378898355-31290-3-git-send-email-bilhuang@nvidia.com>
Message-ID: <20130912101459.GG30013@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 01:19:14PM +0200, Bill Huang wrote:

> +static inline int tegra_cpufreq_init(void)
> +{
> +       retrun EOPNOTSUPP;

This should be -EOPNOTSUPP at least. I think -EINVAL might be better.

Cheers,

Peter.
