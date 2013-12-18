From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 18 Dec 2013 16:20:52 +0800
Subject: [PATCH 1/4] ARM: tegra: moving tegra_bct_strapping to
 tegra-soc.h for global visibility
In-Reply-To: <52B0D5EF.5090703@wwwdotorg.org>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
 <1387272400-4689-2-git-send-email-josephl@nvidia.com>
 <52B0D5EF.5090703@wwwdotorg.org>
Message-ID: <1387354852.2576.4.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-18 at 06:53 +0800, Stephen Warren wrote:
> On 12/17/2013 02:26 AM, Joseph Lo wrote:
> > This patch moves the tegra_btc_strapping variable to the tegra-soc.h for
> > the global visibility that the other Tegra device driver can access it.
> > It also a preparation that we can move out the Tegra20 EMC driver from
> > mach-tegra to the drivers folder.
> 
> Rather than introduce yet more dependencies between the Tegra tree and
> other trees for 3.14, I'd like to see the two clock changes in this
> series taken into the clock tree for 3.14, and the other 2 patches
> deferred for 3.15.
> 
OK, sounds fine to me. So I will just update 2/4 in this series after
squashing 2/4 and 4/4 into one patch. And resend the other two patches
when 3.14-rc1 shows up.

> Joseph, I assume that if patches 2/4 and 4/4 are applied without patches
> 1/4 and 3/4, there will be no issues?
Yes. It's OK.
> 
> This patch looks fine, I think ...
