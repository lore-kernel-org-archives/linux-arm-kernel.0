From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 10:49:47 -0600
Subject: [PATCH V3] ARM: tegra: enable gpio-keys on dalmore
In-Reply-To: <1373439643-16633-1-git-send-email-ldewangan@nvidia.com>
References: <1373439643-16633-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <51E4282B.5040905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2013 01:00 AM, Laxman Dewangan wrote:
> Dalmore have the keys mounted on board which are connected
> to different pins of Tegra.
> 
> Add the keys entry in DTS file to enable key functionality.
> This will enable KEY_POWER, KEY_HOME, KEY_VOLUMEUP and
> KEY_VOLUMEDOWN.

I have applied this to Tegra's for-3.12/dt branch.
