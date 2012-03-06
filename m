From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Mar 2012 09:55:12 -0700
Subject: [PATCH/RFC 1/2] arm/tegra: fix harmony pinmux for PCIe
In-Reply-To: <1331023544-6439-2-git-send-email-mad_soft@inbox.ru>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
 <1331023544-6439-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <4F564170.7000209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 01:45 AM, Dmitry Artamonow wrote:
> Commit 6e96aca397 (arm/tegra: Harmony PCIe: Don't touch pinmux)
> removed runtime tri-state toggling for PCIe related pinmux groups,
> but it seems that the fact that all of them are tri-state by default
> has been overlooked. Change defaults for these groups to TEGRA_TRI_NORMAL.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Crap, why didn't I check that? Anyway,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
