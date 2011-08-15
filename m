From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 15 Aug 2011 09:03:03 -0700
Subject: [RFC PATCH 12/12] arm/tegra: Remove temporary gpio/pinmux
	registration workaround
In-Reply-To: <4E48FF29.1030208@ru.mvista.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-13-git-send-email-swarren@nvidia.com>
	<4E48FF29.1030208@ru.mvista.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25053@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote at Monday, August 15, 2011 5:13 AM:
> Hello.
> 
> On 13-08-2011 2:54, Stephen Warren wrote:
> 
> > This reverts commit "arm/tegra: Prevent duplicate gpio/pinmux pdev
> 
>     Would be good to also include the commit ID for gitweb.

I can't do that yet, because the commit that's being reverted is earlier
in the patch series being posted, and hence doesn't have a commit ID that
will be valid in any upstream repository.

I suppose this is the last commit in the series though, so I could remove
it and submit the revert separately once the rest is upstream.

> > registration with dt"; board-dt.c no long calls harmony/
> > seaboard_pinmux_init(), so the workaround is no longer needed.
> 
> > Signed-off-by: Stephen Warren<swarren@nvidia.com>
> 
> WBR, Sergei

-- 
nvpublic
