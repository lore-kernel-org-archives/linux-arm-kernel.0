From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 12 Apr 2011 15:12:43 +0400
Subject: [PATCH] ARM: Tegra: Harmony: Fix conflicting GPIO numbering
In-Reply-To: <1302558541-19841-1-git-send-email-swarren@nvidia.com>
References: <1302558541-19841-1-git-send-email-swarren@nvidia.com>
Message-ID: <4DA433AB.4040508@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-04-2011 1:49, Stephen Warren wrote:

> Currently, both the WM8903 and TPS6586x chips attempt to register with
> gpiolib using the same GPIO numbers. This causes the audio driver to
> fail to initialize.

> To solve this, add a define to board-harmony.h for the TPS6586x, and make
> oard-harmony-power.c use this define, instead of directly referencing
> TEGRA_NR_GPIOS.

> This fixes a regression introduced by commit
> 6f168f2fa60f87e85e0df25e87e2372f22f5eb7c.

    Please specify the commit's summary in parens -- for the human readers.

> Signed-off-by: Stephen Warren<swarren@nvidia.com>

WBR, Sergei
