From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Oct 2012 09:53:46 -0600
Subject: [PATCH] ARM: tegra30: clocks: add AHB and APB clocks
In-Reply-To: <1350628693-1190-1-git-send-email-josephl@nvidia.com>
References: <1350628693-1190-1-git-send-email-josephl@nvidia.com>
Message-ID: <5081778A.8000006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2012 12:38 AM, Joseph Lo wrote:
> Adding the AHB and APB bus clock control interface for Tegra30.

Not really "clock control interface" but just "clocks". I can reword
that when applying the patch though.

The code seems reasonable. I'd like review from Prashant or Peter though.
