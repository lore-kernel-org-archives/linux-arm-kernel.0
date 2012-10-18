From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Oct 2012 16:39:34 -0600
Subject: [PATCH 1/5] ARM: tegra: Add slink controller base address
In-Reply-To: <1350557795-31487-2-git-send-email-ldewangan@nvidia.com>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
 <1350557795-31487-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <50808526.1080504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 04:56 AM, Laxman Dewangan wrote:
> Add base address of all slink controller of Tegra20
> and tegra30.

Lets not add anything to iomap.h; we're trying to remove it. Instead,
just put the raw address in the AUXDATA; I assume that's the only place
these defines end up being used...
