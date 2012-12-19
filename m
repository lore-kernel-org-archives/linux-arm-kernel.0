From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Dec 2012 10:04:05 -0700
Subject: [PATCH] ARM: tegra30: tegra30 gpio is not compatible with tegra20
 gpio
In-Reply-To: <1355929032-26549-1-git-send-email-ldewangan@nvidia.com>
References: <1355929032-26549-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <50D1F385.7000506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2012 07:57 AM, Laxman Dewangan wrote:
> tegra30 gpio controller is not compatible with the tegra20 due to
> their bank stride i.e. Tegra20 bank stride is 0x80 where Tegra30
> bank stride is 0x100.

Thanks, I've been meaning to clean this up for a while, but never got
around to it. I can apply after the merge window is closed; I don't
think it's important enough to warrant going into 3.8 or earlier, since
it doesn't cause any active problems.

Have you checked all the other devices to make sure they're all correct to?
