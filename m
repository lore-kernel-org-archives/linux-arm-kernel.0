From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 15 Aug 2011 15:12:41 +0400
Subject: [RFC PATCH 12/12] arm/tegra: Remove temporary gpio/pinmux
	registration workaround
In-Reply-To: <1313189697-21287-13-git-send-email-swarren@nvidia.com>
References: <1313189697-21287-1-git-send-email-swarren@nvidia.com>
	<1313189697-21287-13-git-send-email-swarren@nvidia.com>
Message-ID: <4E48FF29.1030208@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-08-2011 2:54, Stephen Warren wrote:

> This reverts commit "arm/tegra: Prevent duplicate gpio/pinmux pdev

    Would be good to also include the commit ID for gitweb.

> registration with dt"; board-dt.c no long calls harmony/
> seaboard_pinmux_init(), so the workaround is no longer needed.

> Signed-off-by: Stephen Warren<swarren@nvidia.com>

WBR, Sergei
