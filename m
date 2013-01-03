From: pengw@nvidia.com (Peng Wu)
Date: Wed, 2 Jan 2013 16:16:59 -0800
Subject: [PATCH 1/2] ARM: DT: tegra: Add board level compatible properties
In-Reply-To: <50E4CD40.10903@wwwdotorg.org>
References: <1357170831-7836-1-git-send-email-pengw@nvidia.com>
 <50E4CB34.6070205@wwwdotorg.org> <50E4CCB3.2040704@nvidia.com>
 <50E4CD40.10903@wwwdotorg.org>
Message-ID: <50E4CDFB.6010301@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2013 04:13 PM, Stephen Warren wrote:
>>> Do you have any idea when SATA support could be added?
>> Oh, do you have SATA driver merged into upstream yet?
> The driver isn't there yet, but it'd be great to add it.

SATA looks like share some code like clock with PCI-E, I think we are 
working on upstream PCI-E driver. Anyway, I will look at this.

Thanks,
-Bryan
