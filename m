From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 06 May 2013 13:49:58 -0600
Subject: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <51880966.9060503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> 
> - Enable pcie root port 2 for cardhu
> - Make private data structure for each SOC
> - Add required tegra3 clocks and regulators
> - Add tegra3 specific code in enable controller
> - Modify clock tree to get clocks based on device
> - Based on git://gitorious.org/thierryreding/linux.git

Jay, I made quite a few comments on this series, and pointed out that it
didn't actually work for me. Are you planning on fixes these issues and
reposting?
