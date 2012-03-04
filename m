From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Mar 2012 10:51:55 -0800
Subject: [PATCH] ARM: tegra: Enable CPUIdle on Tegra20
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC9AB@HQMAIL01.nvidia.com>
References: <1330014056-26125-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC9AB@HQMAIL01.nvidia.com>
Message-ID: <20120304185155.GA363@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 09:25:34AM -0800, Stephen Warren wrote:
> Peter De Schrijver wrote at Thursday, February 23, 2012 9:21 AM:
> > As the LP3 code also works for Tegra20, we can enable cpuidle for Tegra20.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> Note that the commit which added this line appears to have been made in
> Nicolas's idle branch, which was merged into Russell's for-armsoc branch.
> This presumably impacts the path through which this fix should get merged.
> 
> (hence leaving the patch below for Nicolas/Russell to see)

Thanks, applied.


-Olof
