From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Feb 2013 11:18:01 -0700
Subject: [PATCH 1/2] ARM: Tegra: Add clock entry for smp_twd clock
In-Reply-To: <1362037381-4730-1-git-send-email-pgaikwad@nvidia.com>
References: <1362037381-4730-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <512F9F59.5030702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2013 12:43 AM, Prashant Gaikwad wrote:
> As DT support for clocks and smp_twd is enabled, add clock entry
> for smp_twd clock to DT.

Is this a cleanup for 3.10, or a bug-fix for 3.9? Perhaps it solves the
"twd: clock not found" bug I reported?
