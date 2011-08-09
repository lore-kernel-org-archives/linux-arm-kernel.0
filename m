From: olof@lixom.net (Olof Johansson)
Date: Tue, 9 Aug 2011 12:30:52 -0700
Subject: [PATCH] ARM: Tegra: Force PORT_TEGRA as the UART type
In-Reply-To: <1312837265-11984-1-git-send-email-swarren@nvidia.com>
References: <1312837265-11984-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110809193052.GA4145@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2011 at 03:01:05PM -0600, Stephen Warren wrote:
> 8250.c recently gained an explicit PORT_TEGRA port type. Specifically
> request this in all Tegra boards' UART platform data.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to boards-for-3.2.


-Olof
