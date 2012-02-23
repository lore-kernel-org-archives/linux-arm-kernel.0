From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 23 Feb 2012 09:00:55 -0800
Subject: [PATCH] ARM: tegra: Avoid compiling cpuidle code when not
 configured
In-Reply-To: <1330014112-26203-1-git-send-email-pdeschrijver@nvidia.com>
References: <1330014112-26203-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC984@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, February 23, 2012 9:22 AM:
> No need to compile cpuidle.c and sleep.S if cpuidle isn't configured in the
> kernel.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

It doesn't really need it since it's such a small change, but since I
bothered to compile-test it:

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
