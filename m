From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 13 Jan 2012 18:55:43 +0900
Subject: [PATCH] ARM: Fix typo in conversion of ARCH_NR_GPIOS to Kconfig
In-Reply-To: <1325795370-21576-1-git-send-email-swarren@nvidia.com>
References: <1325795370-21576-1-git-send-email-swarren@nvidia.com>
Message-ID: <CANqRtoRnLZewfcQ-ZNd0yGodq0-xia3ND4E9gQminU=fkyh0Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 6, 2012 at 5:29 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Commit 44986ab "ARM: 7240/1: Make ARCH_NR_GPIO a Kconfig variable"
> spelled ARCH_NR_GPIOS as ARCH_NR_GPIO, hence making the change
> ineffective. This change fixes that.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This should probably go into 3.3 since the patch it fixes is there. I
> don't think this issue affects any Tegra platform, but I didn't investigate
> the other platforms that set CONFIG_ARCH_NR_GPIO by default now.

Thanks for this! We would like to see this included in 3.3 to fix
regressions on most ARM shmobile SoCs.

Acked-by: Magnus Damm <damm@opensource.se>
