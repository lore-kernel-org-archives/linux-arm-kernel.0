From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Feb 2014 10:17:14 -0700
Subject: [PATCH] ARM: tegra: document which Dalmore revisions are supported
In-Reply-To: <1389035749-15261-1-git-send-email-swarren@wwwdotorg.org>
References: <1389035749-15261-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52F2721A.3020100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2014 12:15 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> There are a number of revisions of the Dalmore board, each with a variety
> of incompatible SW-visible HW changes. The Dalmore DT file in the kernel
> only supports HW revision A04. Document this in the DT file.

Applied to Tegra's for-3.15/dt branch.
