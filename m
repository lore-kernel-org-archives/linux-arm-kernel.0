From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 03:43:18 +0100
Subject: [PATCH 5/5] ARM: msm: Move MSM's DT based hardware to
 multi-platform support
In-Reply-To: <1386185952-27259-6-git-send-email-sboyd@codeaurora.org>
References: <1386185952-27259-1-git-send-email-sboyd@codeaurora.org>
 <1386185952-27259-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <201312050343.19327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013, Stephen Boyd wrote:
> The DT based MSM platforms can join the multi-platform builds, so
> introduce a DT based ARCH_MSM option. This option allows DT based
> MSM platforms to be built into the multi-platform kernel. Also
> introduce a hidden ARCH_MSM config that both the DT and non-DT
> platform support code select to avoid churn in places that depend
> on CONFIG_ARCH_MSM.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
