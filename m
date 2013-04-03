From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 15:09:37 -0600
Subject: [PATCH V4 1/2] ARM: dt: tegra: add clock source of PMC
In-Reply-To: <1364988688-24613-2-git-send-email-josephl@nvidia.com>
References: <1364988688-24613-1-git-send-email-josephl@nvidia.com>
 <1364988688-24613-2-git-send-email-josephl@nvidia.com>
Message-ID: <515C9A91.3040602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 05:31 AM, Joseph Lo wrote:
> Adding the bindings of the clock source of PMC in DT.

The series, applied to Tegra's for-3.10/soc branch.

I'd usually apply DT changes to for-3.10/dt, but since the later code
changes depend on this DT change, I included it in the same branch.
