From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2012 23:43:22 -0800
Subject: [PATCH 1/3] ARM: dt: Add binding for Tegra PMC
In-Reply-To: <1327527809-10179-1-git-send-email-swarren@nvidia.com>
References: <1327527809-10179-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120201074322.GH7399@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 02:43:27PM -0700, Stephen Warren wrote:
> The Tegra PMC (Power Management Controller) interfaces with an external
> PMU (Power Management Unit), and controls wake-up from sleep modes.
> 
> This initial binding is the bare minimum required to control the PMC's
> inversion of the PMU's interrupt signal.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, looks reasonable enough. Applied 1-3.


-Olof
