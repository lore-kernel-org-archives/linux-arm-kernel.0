From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 31 Aug 2011 11:25:52 -0700
Subject: [PATCH v3 06/13] dt: add empty for_each_child_of_node,
	of_find_property
In-Reply-To: <1314315824-9687-7-git-send-email-swarren@nvidia.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
	<1314315824-9687-7-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A062@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Thursday, August 25, 2011 5:44 PM:
> The patch adds a couple empty functions for non-dt build, so that
> drivers migrating to dt can save some '#ifdef CONFIG_OF'.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Grant, is there any chance you could apply this one patch without waiting
for the whole series; I just realized that the SDHCI controller changes
I published yesterday rely on this patch to compile. While I did compile-
check them without CONFIG_OF, I also had this patch in that branch and
didn't notice the problem.

Thanks.

-- 
nvpublic
