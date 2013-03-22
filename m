From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Mar 2013 11:37:16 -0600
Subject: [PATCH V2 0/4] ARM: tegra: dalmore: add regulators
In-Reply-To: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
References: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <514C96CC.8000904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 07:47 AM, Laxman Dewangan wrote:
> This series add the regulators for Dalmore platform.
> Dalmore also have the Palma PMIC as primary PMIC but 
> dt population will be send later once DT documentation
> finalize.

The series is applied. The first 3 patches to Tegra's for-3.10/dt
branch, and patch 4 to Tegra's for-3.10/defconfig banch.

In patch 2,

> +		tps65090 at 48 {

I removed "@48" there, since the unit-address isn't required to make the
node name unique.
