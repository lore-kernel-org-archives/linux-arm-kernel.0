From: joe@perches.com (Joe Perches)
Date: Tue, 25 Oct 2011 18:15:07 -0700
Subject: [PATCH] arm/tegra: clk_get should not be fatal
In-Reply-To: <20111025170038.GT1001@tbergstrom-lnx.Nvidia.com>
References: <1319559329-324-1-git-send-email-pdeschrijver@nvidia.com>
	<1319559968.14932.5.camel@Joe-Laptop>
	<20111025170038.GT1001@tbergstrom-lnx.Nvidia.com>
Message-ID: <1319591707.16994.4.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-25 at 20:00 +0300, Peter De Schrijver wrote:
> Is pr_warn any different then pr_warning?

Other than being 3 characters shorter to type and it also
lets some format strings fit sub 80 chars line length?  No.

It is more like dev_warn, netdev_warn, et al.

cheers, Joe
