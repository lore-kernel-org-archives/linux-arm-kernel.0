From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Jan 2013 10:57:30 -0700
Subject: [PATCH 1/2] ARM: tegra: config: enable SERIAL_TEGRA
In-Reply-To: <1358341572-8154-1-git-send-email-ldewangan@nvidia.com>
References: <1358341572-8154-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50F6EA0A.4080904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 06:06 AM, Laxman Dewangan wrote:
> Enable high speed serial driver for tegra platform.

Thanks, I've applied patch 1 to Tegra's for-3.9/defconfig branch and
patch 2 to Tegra's for-3.9/dt branch.

Just as an FYI, the dt branch is merged into my for-next branch, and
sent upstream, before the defconfig branch, so your patch order was
reversed relative to that, but it's not an issue here.

Question: How do I test this; do I just fire up bluez(?) and point it at
the UARTC serial port, or is there more to it?
